#include<stdio.h>
#include<string.h>

#define BUF_SIZE 16

extern void my_memcpy(void *dest, const void *src, size_t n);

int main()
{
    // Variable Definitions
    char buf1[BUF_SIZE] = "aabb";
    char buf2[BUF_SIZE];

    // show elements of an array
    printf("Elements of an array(before copy).\n");
    printf("buf1:%s\n", buf1);
    printf("buf2:%s\n", buf2);

    // copy memory
    my_memcpy(buf2, buf1, 3);  // copy first 3 bytes from buf 1 to buf 2

    // show elements of an array
    printf("Elements of an array(after copy).\n");
    printf("buf1:%s\n", buf1);
    printf("buf2:%s\n", buf2);

    return 0;
}