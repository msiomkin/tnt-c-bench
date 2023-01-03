#!/usr/bin/env tarantool

local fiber = require("fiber")
local log = require("log")
local mylib = require("mylinesa")

local ch = fiber.channel()

local f = fiber.create(function()
    local n = mylib.count_lines("test.csv")
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
