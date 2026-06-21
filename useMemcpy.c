#include<stdio.h>
#include<string.h>

#define BUF_SIZE 16

extern void my_memcpy(void *dest, const void *src, size_t n);

int main()
{
    // 変数定義
    char buf1[BUF_SIZE] = "aabb";
    char buf2[BUF_SIZE];

    // 配列の内容を表示
    printf("配列の要素を表示(コピー前)。\n");
    printf("buf1:%s\n", buf1);
    printf("buf2:%s\n", buf2);

    // メモリをコピーする
    my_memcpy(buf2, buf1, 3);  // buf1の先頭3バイトをbuf2にコピーする

    // 配列の内容を表示
    printf("配列の要素を表示(コピー後)。\n");
    printf("buf1:%s\n", buf1);
    printf("buf2:%s\n", buf2);

    return 0;
}