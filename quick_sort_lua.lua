#!/usr/bin/env tarantool

local clock = require("clock")
local log = require("log")

local function partition(arr, left, right)
    local pivot_value = arr[right]
    local pivot = left - 1

    for i = left, right - 1 do
        if arr[i] <= pivot_value then
            pivot = pivot + 1
            arr[i], arr[pivot] = arr[pivot], arr[i]
        end
    end

    pivot = pivot + 1
    arr[pivot], arr[right] = arr[right], arr[pivot]

    return pivot
end

local function quick_sort(arr, left, right)
    left = left or 1
    right = right or #arr

    if left > 0 and left < right then
        local pivot = partition(arr, left, right)
        quick_sort(arr, left, pivot - 1)
        quick_sort(arr, pivot + 1, right)
    end
end

math.randomseed(os.time())

local array = { }
local n = 10 * 1000 * 1000
for i = 1, n do
    array[i] = math.random(1000000)
end

local start = tonumber(clock.proc64())
quick_sort(array)
local stop = tonumber(clock.proc64())

log.info("Time: %.2f sec", (stop - start) / 1000 / 1000 / 1000)
