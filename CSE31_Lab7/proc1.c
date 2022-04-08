#include <stdio.h>

int sum(int m, int n){
    return m + n;
}

int main(){
    int m = 10;
    int n = 5;
    int z = 0;

    z = sum(m, n);
    printf("%d\n", z);

    return 0;
}

