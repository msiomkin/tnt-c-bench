#!/usr/bin/env tarantool

local log = require("log")
local mylib = require("randcsv")
local timer = require("timer")

local n = tonumber(arg[1]) or 100

local t1, ut1, st1 = timer.exec_time()
log.info("Generating a random CSV-file...\n");
local n = mylib.random_csv("test.csv", n)
local t2, ut2, st2 = timer.exec_time()

log.info("Total lines: %d", n)
log.info("\n Total time: %.2f sec", (t2 - t1) / 100)
log.info("  User time: %.2f sec", (ut2 - ut1) / 100)
log.info("System time: %.2f sec", (st2 - st1) / 100)
