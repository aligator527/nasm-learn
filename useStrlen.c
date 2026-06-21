#include <stdio.h>
#include <stddef.h>

extern size_t my_strlen(const char *str);

int main(void) {
    char str1[16] = "abc";
    char str2[16] = "徳川家康";

    printf("%s have %zu bytes。\n", str1, my_strlen(str1));
    printf("%s have %zu bytes。\n", str2, my_strlen(str2));

    return 0;
}