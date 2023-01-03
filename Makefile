.PHONY: all \
	randcsv \
	lineslc \
	linesf \
	qsortlc \
	qsortf \
	isalpha \
	digsum

all: randcsv \
	lineslc \
	linesf \
	qsortlc \
	qsortf \
	isalpha \
	digsum

randcsv:
	gcc -O3 \
		-shared -o randcsv.so \
		-fPIC \
		-I/usr/local/include/tarantool \
		-I/usr/include/tarantool \
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

digsum:
	gcc -O3 \
		-shared -o digsum.so \
		-fPIC \
		-I/usr/local/include/tarantool \
		-I/usr/include/tarantool \
		digsum_udf.c \
		-lmsgpuck

clean:
	rm -r *.so
