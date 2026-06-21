#include <stdio.h>
#include <stddef.h>

extern size_t my_strcpy(char *dest, const char *src);

int main(void) {
    char str1[16] = "abcdefg";
    char str2[16];

    printf("コピー前のstr2[]の中身：%s\n", str2);

    // 文字列をコピーする
    my_strcpy(str2, str1);  // str1をstr2にコピーする

    printf("コピー後のstr2[]の中身：%s\n", str2);
    printf("\n");

    return 0;
}