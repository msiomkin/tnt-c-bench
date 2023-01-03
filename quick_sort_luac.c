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

static void quick_sort(int* arr, size_t left, size_t right)
{
    if (left >= 0 && left < right) {
        size_t pivot = partition(arr, left, right);
        qsort(arr, left, pivot - 1);
        qsort(arr, pivot + 1, right);
    }
}

static size_t get_lua_array(lua_State* L, int** arr)
{
    luaL_checktype(L, 1, LUA_TTABLE);

    size_t n = lua_objlen(L, 1);
    *arr = malloc(n * sizeof(int));

    for (int i = 1; i <= n; i++) {
        lua_rawgeti(L, 1, i);
        lua_Integer luaint = lua_tointeger(L, 1);
        (*arr)[i - 1] = (int)luaint;
        lua_pop(L, 1);
    }

    return n;
}

static int quick_sort_L(lua_State* L)
{
    int* arr;
    size_t n = pm_get_lua_array(L, &arr);

    quick_sort(arr, 0, n - 1);

    return 0;
}

static const struct luaL_Reg mylib[] = {
    { "tnt_quick_sort", quick_sort_L },
    { NULL, NULL }  /* sentinel */
};

LUA_API int luaopen_cfn(lua_State *L) {
    luaL_register(L, "mylib", mylib);
    return 1;
}
