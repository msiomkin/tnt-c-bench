#!/usr/bin/env lua

local mylib = require("isalphalv")
local timer = require("timerlv")

local t1, ut1, st1 = timer.exec_time()
local counter = 0
local n = 100 * 1000 * 1000
for i = 1, n do
    local c = i % 100
    if mylib.isalpha(c) ~= 0 then
        counter = counter + 1
    end
end
local t2, ut2, st2 = timer.exec_time()

print(("Letters count: %d"):format(counter))
print(("\n Total time: %.2f sec"):format((t2 - t1) / 100))
print(("  User time: %.2f sec"):format((ut2 - ut1) / 100))
print(("System time: %.2f sec"):format((st2 - st1) / 100))
