#!/usr/bin/env tarantool

local log = require("log")
local mylib = require("qsortlc")
local timer = require("timer")

math.randomseed(os.time())

local array = { }
local count = tonumber(arg[1]) or 10 * 1000 * 1000
for i = 1, count do
    array[i] = math.random(10 * 1000 * 1000)
end

local t1, ut1, st1 = timer.exec_time()
mylib.quick_sort(array)
local t2, ut2, st2 = timer.exec_time()

log.info("Total time: %.2f sec", (t2 - t1) / 100)
log.info("  User time: %.2f sec", (ut2 - ut1) / 100)
log.info("System time: %.2f sec", (st2 - st1) / 100)
