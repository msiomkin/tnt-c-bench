#include <lua.h>
#include <lauxlib.h>
#include <ctype.h>

static int isalpha_L(lua_State* L)
{
    int n = lua_tointeger(L, 1);
    int r = isalpha(n);
    lua_pushnumber(L, r);

    return 1;
}

static const struct luaL_Reg mylib[] = {
    { "isalpha", isalpha_L },
    { NULL, NULL }
};

LUA_API int luaopen_isalpha(lua_State *L) {
    luaL_register(L, "isalpha", mylib);
    return 1;
}
