#!/usr/bin/env tarantool

local clock = require("clock")
local ffi = require("ffi")
local log = require("log")

ffi.cdef([[
    int count_lines(const char* filename);
]])

local mylib = ffi.load("./linesf.so")

local start = tonumber(clock.proc64())
local n = mylib.count_lines("test.csv")
local stop = tonumber(clock.proc64())

log.info("Line count: %d", n)
log.info("Time: %.2f sec", (stop - start) / 1000 / 1000 / 1000)
