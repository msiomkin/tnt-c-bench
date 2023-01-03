#!/usr/bin/env tarantool

local clock = require("clock")
local log = require("log")
local mylib = require("qsort_luac")

math.randomseed(os.time())

local array = { }
local count = 10 * 1000 * 1000
for i = 1, count do
    array[i] = math.random(1000000)
end

local start = tonumber(clock.proc64())
mylib.quick_sort(array)
local stop = tonumber(clock.proc64())

log.info("Time: %.2f sec", (stop - start) / 1000 / 1000 / 1000)
