#include <stdio.h> 
 
int main() { 
    int x=0, y=0, *px, *py; 
    int arr[10]; 

    
    printf("%d\n",x);
    printf("%d\n",x);

    printf("%p\n", &x);
    printf("%p\n", &y);

    printf("-------------------------------\n");
    printf("Assigning x to px and y to py...\n");

    px = &x;
    py = &y;

    printf("%d\n", *px);
    printf("%p\n", &px);

    printf("%d\n", *py);
    printf("%p\n", &py);

    printf("-------------------------------\n");
    printf("Printing array with pointers...\n");

    int *a = arr;

    for(int i=0; i<10; i++){
        printf("%d\n", *a);
        printf("%p\n", &a);
        a++;
    }

    printf("%p\n", *arr);
    printf("%d\n", &arr);
    
    if(arr==&arr[0]){
        printf("True\n");
    }
    else{
        printf("False\n");
    }


        
    return 0; 
} 