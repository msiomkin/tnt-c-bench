#!/usr/bin/env tarantool

jit.off()
jit.flush()

local log = require("log")
local mylib = require("isalpha")
local timer = require("timer")

local t1, ut1, st1 = timer.exec_time()
local counter = 0
local n = 100 * 1000 * 1000
for i = 1, n do
    local c = i % 100
    if mylib.isalpha(c) ~= 0 then
        counter = counter + 1
    end
end
local t2, ut2, st2 = timer.exec_time()

log.info("Letters count: %d", counter)
log.info("\n Total time: %.2f sec", (t2 - t1) / 100)
log.info("  User time: %.2f sec", (ut2 - ut1) / 100)
log.info("System time: %.2f sec", (st2 - st1) / 100)
