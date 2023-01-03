# Tarantool C vs Lua Benchmark

## This benchmark contains the following examples:

`random_csv_luac.c` - generate a random CSV-file in *C* with a wrapper for *Lua C API* for *LuaJIT*<br/>
`random_csv_luac.lua` - call *C*-implementation using *Lua C API* from *LuaJIT*<br/>
`random_csv_luaj.lua` - generate a random CSV-file in *LuaJIT* (very slow!)<br/>

`lines_luaj.lua` - count file lines in *LuaJIT*<br/>
`lines_luaj_joff.lua` - count file lines in *LuaJIT* with disabled JIT<br/>
`lines_luac.c` - count file lines in *C* with a wrapper for *Lua C API* for *LuaJIT*<br/>
`lines_luac.lua` - call *C*-implementation using *Lua C API* from *LuaJIT*<br/>
`lines_ffi.c` - count file lines in *C*, no wrapper<br/>
`lines_ffi.lua` - call *C*-implementation via *FFI* from *LuaJIT*<br/>
`lines_luav.lua` - count file lines in ("vanilla") *Lua*<br/>

`qsort_luaj.lua` - quick sort in *LuaJIT*<br/>
`qsort_luaj_joff.lua` - quick sort in *LuaJIT* with disabled JIT<br/>
`qsort_luac.c` - quick sort in *C* with a wrapper for *Lua C API* for *LuaJIT*<br/>
`qsort_luac.lua` - call *C*-implementation using *Lua C API* from *LuaJIT*<br/>
`qsort_ffi.c` - quick sort in *C*, no wrapper<br/>
`qsort_ffi.lua` - call *C*-implementation via *FFI* from *LuaJIT*<br/>
`qsort_luav.lua` - quick sort in ("vanilla") *Lua*<br/>

`isalpha_luac.c` - *Lua C API* wrapper for standard *C* `isalpha` function for *LuaJIT*<br/>
`isalpha_luac.lua` - call standard *C* `isalpha` function using *Lua C API* from *LuaJIT*<br/>
`isalpha_luac_joff.lua` - call standard *C* `isalpha` function using *Lua C API* from *LuaJIT* with disabled JIT<br/>
`isalpha_ffi.lua` - call standard *C* `isalpha` function using *FFI* from *LuaJIT*<br/>
`isalpha_ffi_joff.lua` - call standard *C* `isalpha` function using *FFI* from *LuaJIT* with disabled JIT<br/>
`isalpha_luav.c` - *Lua C API* wrapper for standard *C* `isalpha` function for ("vanilla") *Lua*<br/>
`isalpha_luav.lua` - call standard *C* `isalpha` function using *Lua C API* from ("vanilla") *Lua*<br/>

`digsum_lua.lua` - implement and call digits sum *SQL* *Lua*-function<br/>
`digsum_udf.c` - digits sum function for *SQL* in *C*<br/>
`digsum_c.lua` - call digits sum *SQL* *C*-function<br/>

## The Programming Languages Used, Interaction Mechanisms and Target Environments

File|Language|Interaction Mechanism|Target Environment|JIT on/off
--- | --- | --- | --- | ---
random_csv_luac.c|C|Lua C API|LuaJIT|-
random_csv_luac.lua|Lua|Lua C API|LuaJIT|on
random_csv_luaj.lua|Lua|-|LuaJIT|on
lines_luaj.lua|Lua|-|LuaJIT|on
lines_luaj_joff.lua|Lua|-|LuaJIT|off
lines_luac.c|C|Lua C API|LuaJIT|-
lines_luac.lua|Lua|Lua C API|LuaJIT|on
lines_ffi.c|C|FFI|LuaJIT|-
lines_ffi.lua|Lua|FFI|LuaJIT|on
lines_luav.lua|Lua|-|Lua|-
qsort_luaj.lua|Lua|-|LuaJIT|on
qsort_luaj_joff.lua|Lua|-|LuaJIT|off
qsort_luac.c|C|Lua C API|LuaJIT|-
qsort_luac.lua|Lua|Lua C API|LuaJIT|on
qsort_ffi.c|C|FFI|LuaJIT|-
qsort_ffi.lua|Lua|FFI|LuaJIT|on
qsort_luav.lua|Lua|-|Lua|-
isalpha_luac.c|C|Lua C API|LuaJIT|-
isalpha_luac.lua|Lua|Lua C API|LuaJIT|on
isalpha_luac_joff.lua|Lua|Lua C API|LuaJIT|off
isalpha_ffi.lua|Lua|FFI|LuaJIT|on
isalpha_ffi_joff.lua|Lua|FFI|LuaJIT|off
isalpha_luav.c|C|Lua C API|Lua|-
isalpha_luav.lua|Lua|Lua C API|Lua|-
digsum_lua.lua|Lua|-|LuaJIT|on
digsum_udf.c|C|SQL-engine|LuaJIT|-
digsum_c.lua|Lua|SQL-engine|LuaJIT|on