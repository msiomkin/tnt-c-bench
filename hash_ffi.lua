#!/usr/bin/env tarantool

local clock = require("clock")
local ffi = require("ffi")
local log = require("log")
local uuid = require("uuid")

ffi.cdef([[
    unsigned int tnt_hash(const char* str, unsigned int n);
]])

local package = package.search("mylib")
local mylib = ffi.load(package)

local start = tonumber(clock.proc64())
local s = 0
for _ = 1, 10 * 1000 * 1000 do
    s = s + mylib.tnt_hash(uuid.str(), 100)
end
local stop = tonumber(clock.proc64())

log.info(("Sum: %d"):format(s))
log.info("Time: %.2f sec", (stop - start) / 1000 / 1000 / 1000)
