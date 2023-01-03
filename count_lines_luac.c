#include <lua.h>
#include <lauxlib.h>
#include <stdio.h>

static int count_lines(const char* filename)
{
    FILE* file = fopen(filename, "r");

    if (file == NULL)
        return -1;

    #define BUF_SIZE 65536
    char buf[BUF_SIZE];
    int counter = 0;
    for(;;)
    {
        size_t res = fread(buf, 1, BUF_SIZE, file);
        if (ferror(file)) {
            counter = -1;
            break;
        }

        int i;
        for(i = 0; i < res; i++)
            if (buf[i] == '\n')
                counter++;

        if (feof(file))
            break;
    }

    fclose(file);

    return counter;
}

static int count_lines_L(lua_State* L)
{
    const char* filename = lua_tostring(L, 1); /* читаем первый аргумент */
    int n = pm_count_lines(filename);
    lua_pushnumber(L, n); /* возвращаем кол-во строк */

    return 1; /* один результат */
}

static const struct luaL_Reg mylib[] = {
    { "tnt_count_lines", count_lines_L },
    { NULL, NULL }  /* sentinel */
};

LUA_API int luaopen_cfn(lua_State *L) {
    luaL_register(L, "mylib", mylib);
    return 1;
}
