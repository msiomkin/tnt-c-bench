#include <lua.h>
#include <lauxlib.h>

static void swap(int* a, int* b)
{
    int buf = *a;
    *a = *b;
    *b = buf;
}

static int partition(int* arr, int left, int right)
{
    int pivot_value = arr[right];
    int pivot_pos = left - 1;

    for (int i = left; i < right; i++)
        if (arr[i] < pivot_value)
            swap(&arr[i], &arr[++pivot_pos]);

    swap(&arr[right], &arr[++pivot_pos]);

    return pivot_pos;
}

void tnt_quick_sort(int* arr, int left, int right)
{
    if (left < right) {
        int pivot_pos = partition(arr, left, right);
        tnt_quick_sort(arr, left, pivot_pos - 1);
        tnt_quick_sort(arr, pivot_pos + 1, right);
    }
}
