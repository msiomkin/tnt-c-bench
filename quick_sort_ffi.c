#include <lua.h>
#include <lauxlib.h>

static void swap(int* arr, size_t i, size_t j)
{
    int buf = arr[i];
    arr[i] = arr[j];
    arr[j] = buf;
}

static size_t partition(int* arr, int left, int right)
{
    int pivot_value = arr[right];
    size_t pivot = left - 1;

    for (int i = left; i < right; i++)
        if (arr[i] <= pivot_value)
            pm_swap(arr, i, ++pivot);

    pm_swap(arr, right, ++pivot);

    return pivot;
}

void tnt_quick_sort(int* arr, size_t left, size_t right)
{
    if (left >= 0 && left < right) {
        size_t pivot = partition(arr, left, right);
        qsort(arr, left, pivot - 1);
        qsort(arr, pivot + 1, right);
    }
}
