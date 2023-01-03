#include <lua.h>
#include <lauxlib.h>
#include <sys/times.h>

static int exec_time_L(lua_State* L)
{
    struct tms et;
    clock_t total = times(&et);

    lua_pushnumber(L, total);
    lua_pushnumber(L, et.tms_utime);
    lua_pushnumber(L, et.tms_stime);

    return 3;
}

static const struct luaL_Reg mylib[] = {
    { "exec_time", exec_time_L },
    { NULL, NULL }
};

LUA_API int luaopen_timerlv(lua_State *L) {
    luaL_newlib(L, mylib);
    return 1;
}
