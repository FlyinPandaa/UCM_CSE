#include <stdio.h>

int main(){
    int x, y;

    printf("Enter number of times to repeat punishment phrase: \n");
    scanf("%d",&x);

    if(x <= 0){
        while(x <= 0){
            printf("You entered an invalid value for the number of repetition!\n");
            printf("Enter number of times to repeat punishment phrase again: \n");
            scanf("%d",&x);
        }
    }

    printf("Enter the repetition line where you want to introduce the typo: \n");
    scanf("%d",&y);

    if(y <= 0){
        while(y <= 0){
            printf("You entered an invalid value for the typo placement!\n");
            printf("Enter the repetition line where you want to introduce the typo again: \n");
            scanf("%d",&y);
        }
    }

    for(int i=0; i < x; i++){
        if(i == y){
            printf("Programming in C is phun!\n");
        }
        else{
            printf("Programming in C is fun!\n");
        }
    }

    return 0;
}