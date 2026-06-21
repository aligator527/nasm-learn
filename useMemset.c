#include<stdio.h>
#include<string.h>

#define BUF_SIZE 16

extern void *my_memset(void *s, int c, size_t n);

int main()
{
    // Variable Definitions
    char buf1[BUF_SIZE];
    char buf2[BUF_SIZE];

    // Variable Initialization
    my_memset(buf1, '\0', BUF_SIZE);
    my_memset(buf2, '\0', BUF_SIZE);

    // Display the contents of an array
    printf("Display the elements of the array after initialization.\n");
    printf("buf1:%s\n", buf1);
    printf("buf2:%s\n", buf2);

    // Fill a memory region with a specific character   
    my_memset(buf1, 'a', 4);  // Set the first 4 bytes of buf1 to 'a'
    my_memset(buf1, 'b', 2);  // Set the first 2 bytes of buf1 to "b"
    my_memset(buf2, 'c', 3);  // Set the first 3 bytes of buf2 to 'c'

    // Display the contents of an array
    printf("Display the elements of an array.\n");
    printf("buf1:%s\n", buf1);
    printf("buf2:%s\n", buf2);

    return 0;
}