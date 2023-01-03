#!/usr/bin/env tarantool

local clock = require("clock")
local fiber = require("fiber")
local log = require("log")

math.randomseed(os.time())

box.cfg({ memtx_memory = 4 * 1024 * 1024 * 1024 })

local test_space = box.space.test
if test_space ~= nil then
    test_space:drop()
end

test_space = box.schema.create_space("test", {
    format = {
        { name = "id", type = "unsigned" },
        { name = "value", type = "unsigned" }
    },
    temporary = true
})

test_space:create_index("primary")

box.schema.func.drop("mydigsum.tnt_digit_sum", { if_exists = true })
box.schema.func.create("mydigsum.tnt_digit_sum", {
    language = "C",
    exports = { "SQL" },
    param_list = { "unsigned" },
    returns = "unsigned",
    is_deterministic = true
})
box.schema.role.grant("public", "execute", "function", "mydigsum.tnt_digit_sum")


log.info("Generating data...")
local max_value = 2 ^ 32
local n = 10 * 1000 * 1000
for i = 1, n do
    local value = math.random(max_value)
    test_space:insert({ i, value })

    if i % 100000 == 0 then
        log.info("Inserted rows: %d", i)
    end
end


log.info("Running a query...")
local start = tonumber(clock.proc64())
local res, err = box.execute([[
    SELECT COUNT(*)
    FROM "test"
    WHERE "mydigsum.tnt_digit_sum"("value") < 10
]])
local stop = tonumber(clock.proc64())

if res == nil then
    error(err)
end

log.info("Result: %d", res.rows[1][1])
log.info("Time: %.2f sec", (stop - start) / 1000 / 1000 / 1000)

fiber.yield()

os.exit()
