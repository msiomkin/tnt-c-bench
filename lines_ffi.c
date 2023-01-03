#include <stdio.h>
#include <string.h>

int count_lines(const char* filename)
{
    FILE* file = fopen(filename, "r");

    if (file == NULL)
        return -1;

    #define BUF_SIZE 65536
    char buf[BUF_SIZE];
    int counter = 0;
    for(;;)
    {
        ssize_t n = fread(buf, 1, BUF_SIZE, file);
        if (ferror(file)) {
            counter = -1;
            break;
        }

        char* p = buf;
        while (n > 0) {
            char* q = (char*)memchr(p, '\n', n);
            if (q == 0)
                break;
            counter++;
            q++;
            n -= (ssize_t)(q - p);
            p = q;
        }

        if (feof(file))
            break;
    }

    fclose(file);

    return counter;
}
