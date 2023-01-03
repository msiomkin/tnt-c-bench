#!/usr/bin/env tarantool

local clock = require("clock")
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

box.schema.func.drop("DIGIT_SUM", { if_exists = true })
box.schema.func.create("DIGIT_SUM", {
    language = "LUA",
    exports = { "SQL" },
    param_list = { "unsigned" },
    body = [[
            function(n)
                local s = 0
                while n > 0 do
                    local r = n % 10
                    s = s + r
                    n = (n - r) / 10
                end

                return s
            end
        ]],
    returns = "unsigned",
    is_deterministic = true
})
box.schema.role.grant("public", "execute", "function", "DIGIT_SUM")


log.info("Generating data...")
local max_value = 2 ^ 32
for i = 1, 10 * 1000 * 1000 do
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
    WHERE DIGIT_SUM("value") < 10
]])
local stop = tonumber(clock.proc64())

if res == nil then
    error(err)
end

log.info("Result: %d", res.rows[1][1])
log.info("Time: %.2f sec", (stop - start) / 1000 / 1000 / 1000)

os.exit()
