#include<stdio.h>
#include<string.h>

#define BUF_SIZE 16

extern void *my_memset(void *s, int c, size_t n);

int main()
{
    // 変数定義
    char buf1[BUF_SIZE];
    char buf2[BUF_SIZE];

    // 変数初期化
    my_memset(buf1, '\0', BUF_SIZE);
    my_memset(buf2, '\0', BUF_SIZE);

    // 配列の内容を表示
    printf("初期化後の配列の要素を表示。\n");
    printf("buf1:%s\n", buf1);
    printf("buf2:%s\n", buf2);

    // メモリ領域を特定の文字で埋める   
    my_memset(buf1, 'a', 4);  // buf1の最初の4バイトをaにする
    my_memset(buf1, 'b', 2);  // buf1の最初の2バイトをbにする
    my_memset(buf2, 'c', 3);  // buf2の最初の3バイトをcにする

    // 配列の内容を表示
    printf("配列の要素を表示。\n");
    printf("buf1:%s\n", buf1);
    printf("buf2:%s\n", buf2);

    return 0;
}