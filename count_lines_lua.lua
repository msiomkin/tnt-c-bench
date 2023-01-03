#!/usr/bin/env tarantool

local clock = require("clock")
local log = require("log")

local function count_lines(file_name)
    local counter = 0
    for _ in io.lines(file_name) do
        counter = counter + 1
    end

    return counter
end

local start = tonumber(clock.proc64())
local n = count_lines("test.csv")
local stop = tonumber(clock.proc64())

log.info("Line count: %d", n)
log.info("Time: %.2f sec", (stop - start) / 1000 / 1000 / 1000)
