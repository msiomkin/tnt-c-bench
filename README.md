# Tarantool C vs Lua Benchmark

`random_csv_lua.lua` - generate a random CSV-file in *Lua*<br/>
`random_csv_luac.c` - generate a random CSV-file in *C*<br/>
`random_csv_luac.lua` - call random_csv_luac.c via *Lua C*<br/>

`count_lines_lua.lua` - count file lines in *Lua*<br/>
`count_lines_luac.c` - count file lines in *C*<br/>
`count_lines_luac.lua` - call count_lines_luac.c via *Lua C*<br/>

`quick_sort_lua.lua` - quick sort in *Lua*<br/>
`quick_sort_luac.c` - quick sort in C for calling via *Lua C*<br/>
`quick_sort_luac.lua` - call quick_sort_ffi.c via *Lua C*<br/>
`quick_sort_ffi.c` - quick sort in C for calling via *FFI*<br/>
`quick_sort_ffi.lua` - call quick_sort_ffi.c via *FFI*<br/>

`echo.c` - echo number function in *C*<br/>
`echo_luac.lua` - call echo.c via *Lua C*<br/>
`echo_ffi.lua` - call echo.c via *FFI*<br/>

`hash.c` - string hash function in *C*<br/>
`hash_luac.lua` - call hash.c via *Lua C*<br/>
`hash_ffi.lua` - call hash.c via *FFI*<br/>

`digit_sum_lua.lua` - implement and call digits sum *SQL* *Lua*-function<br/>
`digit_sum.c` - digits sum function for *SQL* in *C*<br/>
`digit_sum_c.lua` - call digits sum *SQL* *C*-function<br/>
