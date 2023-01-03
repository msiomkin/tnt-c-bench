#!/usr/bin/env tarantool

local log = require("log")
local timer = require("timer")

local function partition(arr, left, right)
    local pivot_value = arr[right]
    local pivot = left - 1

    for i = left, right - 1 do
        if arr[i] < pivot_value then
            pivot = pivot + 1
            arr[i], arr[pivot] = arr[pivot], arr[i]
        end
    end

    pivot = pivot + 1
    arr[pivot], arr[right] = arr[right], arr[pivot]

    return pivot
end

local function quick_sort(arr, left, right)
    if left > 0 and left < right then
        local pivot = partition(arr, left, right)
        quick_sort(arr, left, pivot - 1)
        quick_sort(arr, pivot + 1, right)
    end
end

math.randomseed(os.time())

local array = { }
local n = tonumber(arg[1]) or 10 * 1000 * 1000
for i = 1, n do
    array[i] = math.random(10 * 1000 * 1000)
end

local t1, ut1, st1 = timer.exec_time()
quick_sort(array, 1, #array)
local t2, ut2, st2 = timer.exec_time()

log.info("Total time: %.2f sec", (t2 - t1) / 100)
log.info("  User time: %.2f sec", (ut2 - ut1) / 100)
log.info("System time: %.2f sec", (st2 - st1) / 100)
