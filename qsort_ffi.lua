#!/usr/bin/env tarantool

local clock = require("clock")
local ffi = require("ffi")
local log = require("log")

ffi.cdef([[
    void quick_sort(int* arr, size_t left, size_t right);
]])

local mylib = ffi.load("./qsortf.so")

math.randomseed(os.time())

local array = { }
local n = 10 * 1000 * 1000
for i = 1, n do
    array[i] = math.random(1000000)
end

local start = tonumber(clock.proc64())
local arg = ffi.new(("int[%d]"):format(n), array)
mylib.quick_sort(arg, 0, n - 1)
local stop = tonumber(clock.proc64())

log.info("Time: %.2f sec", (stop - start) / 1000 / 1000 / 1000)
