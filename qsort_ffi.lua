#!/usr/bin/env tarantool

local ffi = require("ffi")
local log = require("log")
local timer = require("timer")

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

local t1, ut1, st1 = timer.exec_time()
local arg = ffi.new(("int[%d]"):format(n), array)
mylib.quick_sort(arg, 0, n - 1)
local t2, ut2, st2 = timer.exec_time()

log.info("Total time: %.2f sec", (t2 - t1) / 100)
log.info("  User time: %.2f sec", (ut2 - ut1) / 100)
log.info("System time: %.2f sec", (st2 - st1) / 100)
