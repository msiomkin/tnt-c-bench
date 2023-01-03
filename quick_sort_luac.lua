#!/usr/bin/env tarantool

local clock = require("clock")
local log = require("log")
local mylib = require("mylib")

math.randomseed(os.time())

local array = { }
for i = 1, 10 * 1000 * 1000 do
    array[i] = math.random(1000000)
end

local start = tonumber(clock.proc64())
mylib.tnt_quick_sort(array)
local stop = tonumber(clock.proc64())

log.info("Time: %.2f sec", (stop - start) / 1000 / 1000 / 1000)