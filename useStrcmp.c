#include <stdio.h>

extern int strcmp(const char *p1, const char *p2);

int main() {
    char password[] = "Secret123";
    char input[] = "Secret1234";

    if(strcmp(password, input) == 0){
        printf("Access granted.\n");
    } else {
        printf("Access denied.\n");
    }

    return 0;
}