# Tarantool C vs Lua Benchmark

`random_csv_lua.lua` - generate a random CSV-file in *Lua*<br/>
`random_csv_luac.c` - generate a random CSV-file in *C*<br/>
`random_csv_luac.lua` - call *C*-implementation using *Lua C API*<br/>

`lines_lua.lua` - count file lines in *Lua*<br/>
`lines_luac.c` - count file lines in *C* with a wrapper for *Lua C API*<br/>
`lines_luac.lua` - call *C*-implementation using *Lua C API*<br/>
`lines_ffi.c` - count file lines in *C*, no wrapper<br/>
`lines_ffi.lua` - call *C*-implementation via *FFI*<br/>

`qsort_lua.lua` - quick sort in *Lua*<br/>
`qsort_luac.c` - quick sort in *C* with a wrapper for *Lua C API*<br/>
`qsort_luac.lua` - call *C*-implementation using *Lua C API*<br/>
`qsort_ffi.c` - quick sort in *C*, no wrapper<br/>
`qsort_ffi.lua` - call *C*-implementation via *FFI*<br/>

`isalpha_luac.c` - *Lua C API* wrapper for standard *C* `isalpha` function<br/>
`isalpha_luac.lua` - call standard *C* `isalpha` function using *Lua C API*<br/>
`isalpha_ffi.lua` - call standard *C* `isalpha` function using *FFI*<br/>

`digsum_lua.lua` - implement and call digits sum *SQL* *Lua*-function<br/>
`digsum_udf.c` - digits sum function for *SQL* in *C*<br/>
`digsum_c.lua` - call digits sum *SQL* *C*-function<br/>
