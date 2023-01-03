#include <module.h>
#include <msgpuck.h>

static uint64_t sum_digits(uint64_t n)
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
    mp_decode_array(&args); /* читаем кол-во аргументов */

    /* проверяем тип аргумента */
    enum mp_type value_type = mp_typeof(*args);
    if (value_type != MP_UINT) {
        return box_error_raise(-1,
            "Invalid argument type, expecting an unsigned integer");
    }

    uint64_t n = mp_decode_uint(&args); /* читаем значение аргумент */

    uint64_t s = sum_digits(n); /* основная логика */

    char res_buf[9]; /* буфер для результата */
    char* res_end = res_buf; /* указатель на конец буфера */
    /* записываем кол-во возвращаемых значений */
    res_end = mp_encode_array(res_end, 1);
    res_end = mp_encode_uint(res_end, s); /* записываем результат */

    /* помещаем результат в кортеж */
    struct tuple* res = box_tuple_new(box_tuple_format_default(),
        res_buf, res_end);

    return box_return_tuple(ctx, res); /* возвращаем результат */
}
