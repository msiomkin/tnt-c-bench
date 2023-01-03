#include <module.h>
#include <msgpuck.h>

static uint64_t add_digits(uint64_t n)
{
    uint64_t s = 0;
    while (n > 0) {
        int r = n % 10;
        s += r;
        n = n / 10;
    }

    return s;
}

int digit_sum(box_function_ctx_t* ctx, const char* args, const char* args_end)
{
    mp_decode_array(&args); /* get the number of arguments */

    /* check the argument type */
    enum mp_type value_type = mp_typeof(*args);
    if (value_type != MP_UINT) {
        return box_error_raise(-1,
            "Invalid argument type, expecting an unsigned integer");
    }

    uint64_t n = mp_decode_uint(&args); /* read the argument value */

    uint64_t s = add_digits(n); /* main logic */

    char res_buf[1 + sizeof(uint64_t)]; /* the result buffer */
    char* res_end = res_buf; /* a pointer to the end of the buffer */
    /* set the number of return values */
    res_end = mp_encode_array(res_end, 1);
    res_end = mp_encode_uint(res_end, s); /* write the result */

    /* put the result into a tuple */
    struct tuple* res = box_tuple_new(box_tuple_format_default(),
        res_buf, res_end);

    return box_return_tuple(ctx, res); /* return the result */
}
