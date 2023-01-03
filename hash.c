#include <lua.h>
#include <lauxlib.h>

enum { MULTIPLIER = 37 };

unsigned int tnt_hash(const char* str, unsigned int n)
{
    unsigned int h = 0;
    unsigned char* p;

    for (p = (unsigned char*)str; *p != '\0'; p++)
        h = MULTIPLIER * h + *p;
    
    return h % n;
}

static int hash_L(lua_State* L)
{
    const char* str = lua_tostring(L, 1);
    int n = lua_tointeger(L, 2);
    int r = tnt_hash(str, n);
    lua_pushnumber(L, r);

    return 1;
}

static const struct luaL_Reg mylib[] = {
    { "hash", hash_L },
    { NULL, NULL }  /* sentinel */
};

LUA_API int luaopen_mylib(lua_State *L) {
    luaL_register(L, "mylib", mylib);
    return 1;
}
