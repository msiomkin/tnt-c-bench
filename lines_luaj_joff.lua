#!/usr/bin/env tarantool

jit.off()
jit.flush()

local log = require("log")
local timer = require("timer")

local function count_lines(file_name)
    local buf_size = 65536
    local f = io.input(file_name)

    local counter = 0
    while true do
        local buf = f:read(buf_size)
        if buf == nil then
            break
        end

        local i = 0
        while true do
            i = buf:find("\n", i + 1)
            if i == nil then
                break
            end

            counter = counter + 1
        end
    end

    f:close()

    return counter
end

local t1, ut1, st1 = timer.exec_time()
local n = count_lines("test.csv")
local t2, ut2, st2 = timer.exec_time()

log.info("Line count: %d", n)
log.info("\n Total time: %.2f sec", (t2 - t1) / 100)
log.info("  User time: %.2f sec", (ut2 - ut1) / 100)
log.info("System time: %.2f sec", (st2 - st1) / 100)
