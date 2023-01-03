#!/usr/bin/env tarantool

local log = require("log")
local mylib = require("lineslc")
local timer = require("timer")

local t1, ut1, st1 = timer.exec_time()
local n = mylib.count_lines("test.csv")
local t2, ut2, st2 = timer.exec_time()

log.info("Line count: %d", n)
log.info("\n Total time: %.2f sec", (t2 - t1) / 100)
log.info("  User time: %.2f sec", (ut2 - ut1) / 100)
log.info("System time: %.2f sec", (st2 - st1) / 100)
