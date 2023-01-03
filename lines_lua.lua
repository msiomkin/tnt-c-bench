#!/usr/bin/env tarantool

local clock = require("clock")
local log = require("log")

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

local start = tonumber(clock.proc64())
local n = count_lines("test.csv")
local stop = tonumber(clock.proc64())

log.info("Line count: %d", n)
log.info("Time: %.2f sec", (stop - start) / 1000 / 1000 / 1000)
