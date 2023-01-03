#define SWAP_INT(a, b) \
    { \
        int tmp = a; \
        a = b; \
        b = tmp; \
    }

static int partition(int* arr, int left, int right)
{
    int pivot_value = arr[right];
    int pivot_pos = left - 1;

    for (int i = left; i < right; i++)
        if (arr[i] < pivot_value) {
            pivot_pos++;
            SWAP_INT(arr[i], arr[pivot_pos]);
        }

    pivot_pos++;
    SWAP_INT(arr[right], arr[pivot_pos]);

    return pivot_pos;
}

void quick_sort(int* arr, int left, int right)
{
    if (left < right) {
        int pivot_pos = partition(arr, left, right);
        quick_sort(arr, left, pivot_pos - 1);
        quick_sort(arr, pivot_pos + 1, right);
    }
}
