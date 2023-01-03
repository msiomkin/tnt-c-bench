#!/usr/bin/env tarantool

local clock = require("clock")
local log = require("log")
local mylib = require("mylib")
local uuid = require("uuid")

local start = tonumber(clock.proc64())
local s = 0
for _ = 1, 10 * 1000 * 1000 do
    s = s + mylib.hash(uuid.str(), 100)
end
local stop = tonumber(clock.proc64())

log.info(("Sum: %d"):format(s))
log.info("Time: %.2f sec", (stop - start) / 1000 / 1000 / 1000)
