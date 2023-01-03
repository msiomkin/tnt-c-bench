.PHONY: all \
	mylines \
	mylinesa \
	qsort_luac \
	qsort_ffi \
	myecho \
	myhash \
	mydigsum \
	random_csv

all: mylines \
	mylinesa \
	qsort_luac \
	qsort_ffi \
	myecho \
	myhash \
	mydigsum \
	random_csv

mylines:
	gcc -O3 \
		-shared -o mylines.so \
		-fPIC \
		-I/usr/local/include/tarantool \
		count_lines_luac.c

mylinesa:
	gcc -O3 \
		-shared -o mylinesa.so \
		-fPIC \
		-I/usr/local/include/tarantool \
		count_lines_luac_async.c

qsort_luac:
	gcc -O3 \
		-shared -o qsort_luac.so \
		-fPIC \
		-I/usr/local/include/tarantool \
		quick_sort_luac.c

qsort_ffi:
	gcc -O3 \
		-shared -o qsort_ffi.so \
		-fPIC \
		-I/usr/local/include/tarantool \
		quick_sort_ffi.c

myecho:
	gcc -O3 \
		-shared -o myecho.so \
		-fPIC \
		-I/usr/local/include/tarantool \
		echo.c

myhash:
	gcc -O3 \
		-shared -o myhash.so \
		-fPIC \
		-I/usr/local/include/tarantool \
		hash.c

mydigsum:
	gcc -O3 \
		-shared -o mydigsum.so \
		-fPIC \
		-I/usr/local/include/tarantool \
		digit_sum.c \
		-lmsgpuck

random_csv:
	gcc -O3 \
		-shared -o random_csv.so \
		-fPIC \
		-I/usr/local/include/tarantool \
		random_csv_luac.c

clean:
	rm -r *.so
