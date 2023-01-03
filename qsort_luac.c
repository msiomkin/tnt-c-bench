#include <lua.h>
#include <lauxlib.h>
#include <stdlib.h>
#include <module.h>

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

static void quick_sort(int* arr, int left, int right)
{
    if (left < right) {
        int pivot_pos = partition(arr, left, right);
        quick_sort(arr, left, pivot_pos - 1);
        quick_sort(arr, pivot_pos + 1, right);
    }
}

static size_t get_lua_array(lua_State* L, int** arr)
{
    luaL_checktype(L, 1, LUA_TTABLE);

    size_t n = lua_objlen(L, 1);
    *arr = malloc(n * sizeof(int));

    for (int i = 1; i <= n; i++) {
        lua_rawgeti(L, 1, i);
        lua_Integer luaint = lua_tointeger(L, -1);
        (*arr)[i - 1] = (int)luaint;
        lua_pop(L, 1);
    }

    return n;
}

static int quick_sort_L(lua_State* L)
{
    int* arr;
    size_t n = get_lua_array(L, &arr);

    quick_sort(arr, 0, n - 1);

    free(arr);

    return 0;
}

static const struct luaL_Reg mylib[] = {
    { "quick_sort", quick_sort_L },
    { NULL, NULL }
};

LUA_API int luaopen_qsortlc(lua_State *L) {
    luaL_register(L, "qsortlc", mylib);
    return 1;
}
