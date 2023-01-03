#include <lua.h>
#include <lauxlib.h>
#include <module.h>
#include <stdio.h>
#include <string.h>

static ssize_t count_lines(va_list args)
{
    const char* filename = va_arg(args, const char*);

    FILE* file = fopen(filename, "r");

    if (file == NULL)
        return -1;

    #define BUF_SIZE 65536
    char buf[BUF_SIZE];
    int counter = 0;
    for(;;)
    {
        size_t n = fread(buf, 1, BUF_SIZE, file);
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
            n -= (size_t)(q - p);
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
    const char* filename = lua_tostring(L, 1); /* читаем первый аргумент */
    /* асинхронно подсчитываем кол-во строк */
    ssize_t n = coio_call(count_lines, filename);
    lua_pushnumber(L, n); /* возвращаем кол-во строк */

    return 1; /* один результат (возможен multireturn) */
}

/* массив функций для библиотеки */
static const struct luaL_Reg mylib[] = {
    /* в Lua функция будет называться count_lines */
    { "count_lines", count_lines_L },
    /* метка окончания массива регистрируемых функций */
    { NULL, NULL }
};

/* точка входа в Lua C библиотеку */
LUA_API int luaopen_mylinesa(lua_State *L) {
    /* регистрируем функции библиотеки */
    luaL_register(L, "mylinesa", mylib);
    return 1;
}
