#!/usr/bin/env tarantool

local clock = require("clock")
local log = require("log")
local mylib = require("myecho")

local start = tonumber(clock.proc64())
local s = 0
local n = 100 * 1000 * 1000
for i = 1, n do
    s = s + mylib.echo(i)
end
local stop = tonumber(clock.proc64())

log.info(("Sum: %d"):format(s))
log.info("Time: %.2f sec", (stop - start) / 1000 / 1000 / 1000)
