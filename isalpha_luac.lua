#!/usr/bin/env tarantool

local clock = require("clock")
local log = require("log")
local mylib = require("isalpha")

local start = tonumber(clock.proc64())
local counter = 0
local n = 100 * 1000 * 1000
for i = 1, n do
    local c = i % 100
    if mylib.isalpha(c) ~= 0 then
        counter = counter + 1
    end
end
local stop = tonumber(clock.proc64())

log.info(("Letters count: %d"):format(counter))
log.info("Time: %.2f sec", (stop - start) / 1000 / 1000 / 1000)
