#!/usr/bin/env tarantool

local clock = require("clock")
local ffi = require("ffi")
local log = require("log")

math.randomseed(os.time())

local array = { }
local count = 10 * 1000 * 1000
for i = 1, count do
    array[i] = math.random(1000000)
end

ffi.cdef([[
    void tnt_quick_sort(int* arr, size_t left, size_t right);
]])

local package = package.search("mylib")
local mylib = ffi.load(package)

local start = tonumber(clock.proc64())
local arg = ffi.new(("int[%d]"):format(count), array)
mylib.tnt_quick_sort(arg, 0, count - 1)
local stop = tonumber(clock.proc64())

log.info("Time: %.2f sec", (stop - start) / 1000 / 1000 / 1000)
