#!/usr/bin/env tarantool

local fiber = require("fiber")
local log = require("log")
local timer = require("timer")

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

box.schema.func.drop("myudf.digit_sum", { if_exists = true })
box.schema.func.create("myudf.digit_sum", {
    language = "C",
    exports = { "SQL" },
    param_list = { "unsigned" },
    returns = "unsigned",
    is_deterministic = true
})
box.schema.role.grant("public", "execute", "function", "myudf.digit_sum")


log.info("Generating data...")
local max_value = 2 ^ 32
local n = tonumber(arg[1]) or 10 * 1000 * 1000
for i = 1, n do
    local value = math.random(max_value)
    test_space:insert({ i, value })

    if i % 100000 == 0 then
        log.info("Inserted rows: %d", i)
        fiber.yield()
    end
end


log.info("Running a query...")
local t1, ut1, st1 = timer.exec_time()
local res, err = box.execute([[
    SELECT COUNT(*)
    FROM "test"
    WHERE id > 0 AND "myudf.digit_sum"("value") < 10
]])
local t2, ut2, st2 = timer.exec_time()

if res == nil then
    error(err)
end

log.info("Result: %d", res.rows[1][1])
log.info(" Total time: %.2f sec", (t2 - t1) / 100)
log.info("  User time: %.2f sec", (ut2 - ut1) / 100)
log.info("System time: %.2f sec", (st2 - st1) / 100)

fiber.yield()

os.exit()
