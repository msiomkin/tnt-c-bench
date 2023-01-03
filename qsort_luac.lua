#!/usr/bin/env tarantool

local clock = require("clock")
local log = require("log")
local mylib = require("qsortlc")

math.randomseed(os.time())

local array = { }
local count = tonumber(arg[1]) or 10 * 1000 * 1000
for i = 1, count do
    array[i] = math.random(10 * 1000 * 1000)
end

local start = tonumber(clock.proc64())
mylib.quick_sort(array)
local stop = tonumber(clock.proc64())

log.info("Time: %.2f sec", (stop - start) / 1000 / 1000 / 1000)
