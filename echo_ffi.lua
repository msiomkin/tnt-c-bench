#!/usr/bin/env tarantool

local clock = require("clock")
local ffi = require("ffi")
local log = require("log")

ffi.cdef([[
    int tnt_echo(int n);
]])

local mylib = ffi.load("./myecho.so")

local start = tonumber(clock.proc64())
local s = 0
local n = 100 * 1000 * 1000
for i = 1, n do
    s = s + mylib.tnt_echo(i)
end
local stop = tonumber(clock.proc64())

log.info(("Sum: %d"):format(s))
log.info("Time: %.2f sec", (stop - start) / 1000 / 1000 / 1000)
