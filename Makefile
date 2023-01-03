.PHONY: all \
	randcsv \
	lineslc \
	linesf \
	qsortlc \
	qsortf \
	isalpha \
	isalphalv \
	digsum \
	timer \
	timerlv

all: randcsv \
	lineslc \
	linesf \
	qsortlc \
	qsortf \
	isalpha \
	digsum \
	timer \
	isalphalv \
	timerlv

randcsv:
	gcc -O3 \
		-shared -o randcsv.so \
		-fPIC \
		-I/usr/local/include/tarantool \
		-I/usr/include/tarantool \
		-Wno-format \
		random_csv_luac.c

lineslc:
	gcc -O3 \
		-shared -o lineslc.so \
		-fPIC \
		-I/usr/local/include/tarantool \
		-I/usr/include/tarantool \
		lines_luac.c

linesf:
	gcc -O3 \
		-shared -o linesf.so \
		-fPIC \
		-I/usr/local/include/tarantool \
		-I/usr/include/tarantool \
		lines_ffi.c

qsortlc:
	gcc -O3 \
		-shared -o qsortlc.so \
		-fPIC \
		-I/usr/local/include/tarantool \
		-I/usr/include/tarantool \
		qsort_luac.c

qsortf:
	gcc -O3 \
		-shared -o qsortf.so \
		-fPIC \
		-I/usr/local/include/tarantool \
		-I/usr/include/tarantool \
		qsort_ffi.c

isalpha:
	gcc -O3 \
		-shared -o isalpha.so \
		-fPIC \
		-I/usr/local/include/tarantool \
		-I/usr/include/tarantool \
		isalpha_luac.c

isalphalv:
	gcc -O3 \
		-shared -o isalphalv.so \
		-fPIC \
		-I/usr/local/include \
		-I/usr/include \
		-I/usr/include/lua5.3 \
		isalpha_luav.c

digsum:
	gcc -O3 \
		-shared -o myudf.so \
		-fPIC \
		-I/usr/local/include/tarantool \
		-I/usr/include/tarantool \
		digsum_udf.c \
		-lmsgpuck

timer:
	gcc -O3 \
		-shared -o timer.so \
		-fPIC \
		-I/usr/local/include/tarantool \
		-I/usr/include/tarantool \
		timer.c

timerlv:
	gcc -O3 \
		-shared -o timerlv.so \
		-fPIC \
		-I/usr/local/include \
		-I/usr/include \
		-I/usr/include/lua5.3 \
		timerlv.c

clean:
	rm -r *.so
