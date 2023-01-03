#!/usr/bin/env tarantool

local clock = require("clock")
local log = require("log")

box.cfg({ memtx_memory = 4 * 1024 * 1024 * 1024 })

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

log.info("Running a query...")
local start = tonumber(clock.proc64())
local res, err = box.execute([[
    SELECT COUNT(*)
    FROM "test"
    WHERE id > 0 and DIGIT_SUM("value") < 10
]])
local stop = tonumber(clock.proc64())

if res == nil then
    error(err)
end

log.info("Result: %d", res.rows[1][1])
log.info("Time: %.2f sec", (stop - start) / 1000 / 1000 / 1000)

os.exit()
