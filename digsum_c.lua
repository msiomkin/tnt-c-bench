#!/usr/bin/env tarantool

local clock = require("clock")
local log = require("log")

box.cfg({ memtx_memory = 4 * 1024 * 1024 * 1024 })

box.schema.func.drop("digsum.digit_sum", { if_exists = true })
box.schema.func.create("digsum.digit_sum", {
    language = "C",
    exports = { "SQL" },
    param_list = { "unsigned" },
    returns = "unsigned",
    is_deterministic = true
})
box.schema.role.grant("public", "execute", "function", "digsum.digit_sum")

log.info("Running a query...")
local start = tonumber(clock.proc64())
local res, err = box.execute([[
    SELECT COUNT(*)
    FROM "test"
    WHERE id > 0 and "digsum.digit_sum"("value") < 10
]])
local stop = tonumber(clock.proc64())

if res == nil then
    error(err)
end

log.info("Result: %d", res.rows[1][1])
log.info("Time: %.2f sec", (stop - start) / 1000 / 1000 / 1000)

os.exit()
