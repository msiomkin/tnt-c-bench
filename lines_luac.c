#include <lua.h>
#include <lauxlib.h>
#include <stdio.h>
#include <string.h>

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
        ssize_t n = fread(buf, 1, BUF_SIZE, file);
        if (ferror(file)) {
            counter = -1;
            break;
        }

        char* p = buf;
        while (n > 0) {
            char* q = (char*)memchr(p, '\n', n);
            if (q == 0)
                break;
            counter++;
            q++;
            n -= (ssize_t)(q - p);
            p = q;
        }

        if (feof(file))
            break;
    }

    fclose(file);

    return counter;
}

static int count_lines_L(lua_State* L)
{
    const char* filename = lua_tostring(L, 1); /* read the first argument */
    int n = count_lines(filename); /* count the number of lines */
    lua_pushnumber(L, n); /* return the number of lines */

    return 1; /* we have one result value (multireturn is possible) */
}

/* exported functions array */
static const struct luaL_Reg mylib[] = {
    /* the function will be called 'count_lines' in Lua */
    { "count_lines", count_lines_L },
    /* a sentinel for the end of the array */
    { NULL, NULL }
};

/* library entrypoint */
LUA_API int luaopen_lineslc(lua_State *L) {
    /* register library functions */
    luaL_register(L, "lineslc", mylib);
    return 1;
}
