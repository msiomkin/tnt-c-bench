#!/usr/bin/env tarantool

local fiber = require("fiber")
local fio = require("fio")
local log = require("log")

local function count_lines(file_name)
    local buf_size = 65536
    local f = fio.open(file_name, "O_RDONLY")

    local counter = 0
    while true do
        local buf = f:read(buf_size)
        if buf == "" then
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

local ch = fiber.channel()

local f = fiber.create(function()
    local n = count_lines("test.csv")
    ch:put(n)
end)

local n
while f:status() ~= "dead" do
    n = ch:get(0.5)
    if n ~= nil then
        break
    end

    io.write(".")
    io.flush()
end

if n ~= nil then
    log.info("\nLine count: %d", n)
else
    log.error("\nError!")
end
