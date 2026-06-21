#include <stdio.h>
#include <stddef.h>

extern size_t my_strcpy(char *dest, const char *src);

int main(void) {
    char str1[16] = "abcdefg";
    char str2[16];

    printf("The contents of str2[] before copying：%s\n", str2);

    // Copy a string
    my_strcpy(str2, str1);  // Copy str1 to str2

    printf("The contents of `str2[]` after copying：%s\n", str2);
    printf("\n");

    return 0;
}