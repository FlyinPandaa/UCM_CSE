#include <stdio.h>
#include <stdlib.h>
#include <malloc.h>
int main() {
    int num;
    int *ptr;
    int **handle;
    num = 14;
    ptr = (int *)malloc(2 * sizeof(int));
    *ptr = num;
    handle = (int **)malloc(1 * sizeof(int *));
    *handle = ptr;

    printf("Value of num: %d\n", num);
    printf("Address of num: %p\n", &num);

    printf("Value of ptr: %d\n", *ptr);
    printf("Address of ptr: %p\n", &ptr);

    printf("Value of handle: %d\n", **handle);
    printf("Address of handle: %p\n", &handle);

return 0;
} 