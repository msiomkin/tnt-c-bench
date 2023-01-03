#!/usr/bin/env tarantool

local clock = require("clock")
local log = require("log")
local mylib = require("randcsv")

local n = tonumber(arg[1]) or 100

local start = tonumber(clock.proc64())
log.info("Generating a random CSV-file...\n");
local n = mylib.random_csv("test.csv", n)
local stop = tonumber(clock.proc64())

log.info("Total lines: %d", n)
log.info("Total time: %.2f sec", (stop - start) / 1000 / 1000 / 1000)
