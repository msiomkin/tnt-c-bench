#!/usr/bin/env tarantool

local clock = require("clock")
local log = require("log")

box.cfg({ memtx_memory = 4 * 1024 * 1024 * 1024 })

local test_space = box.space.test
if test_space ~= nil then
    test_space:drop()
end

test_space = box.schema.create_space("test", {
    format = {
        { name = "id", type = "unsigned" },
        { name = "value", type = "unsigned" }
    }
})

test_space:create_index("primary")

log.info("Generating data...")

math.randomseed(os.time())

local max_value = 2 ^ 32
local batch_size = 100000
local batch_count = 100
local row_count = 0
for i = 1, batch_count do
    box.atomic(function()
        local value = math.random(max_value)
        for j = 1, batch_size do
            test_space:insert({ row_count + j, value })
        end
    end)

    row_count = row_count + batch_size

    log.info("Inserted rows: %d", row_count)
end

os.exit()
