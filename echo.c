#include <lua.h>
#include <lauxlib.h>

int tnt_echo(int n)
{
    return n;
}

static int echo_L(lua_State* L)
{
    int n = lua_tointeger(L, 1);
    int r = tnt_echo(n);
    lua_pushnumber(L, r);

    return 1;
}

static const struct luaL_Reg mylib[] = {
    { "echo", echo_L },
    { NULL, NULL }  /* sentinel */
};

LUA_API int luaopen_myecho(lua_State *L) {
    luaL_register(L, "myecho", mylib);
    return 1;
}
