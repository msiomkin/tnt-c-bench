#!/usr/bin/env tarantool

local clock = require("clock")
local log = require("log")
local mylib = require("mylines")

local start = tonumber(clock.proc64())
local n = mylib.count_lines("test.csv")
local stop = tonumber(clock.proc64())

log.info("Line count: %d", n)
log.info("Time: %.2f sec", (stop - start) / 1000 / 1000 / 1000)
