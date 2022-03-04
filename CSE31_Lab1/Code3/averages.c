#include <stdio.h>

int main(){
    int temp = 1, inputCount = 1;
    float even =0, odd=0, evenCount = 0, oddCount = 0;

    while(temp != 0){
        int input = 0, sum = 0, mod = 0;

        if(inputCount == 1){
            printf("Please enter the 1st integer: \n");
        } else if(inputCount == 2){
            printf("Please enter the 2nd integer: \n");
        } else if(inputCount == 3){
            printf("Please enter the 3rd integer: \n");
        } else {
            printf("Please enter the %dth integer: \n", inputCount);
        }

        scanf("%d", &input);

        temp = abs(input);

        while(temp != 0){
            mod = temp % 10;
            sum = sum + mod;
            temp = temp / 10;
        }

        sum = sum % 2;

        if(input == 0){
            sum = sum -1;
        }

        if(sum == 1){
            odd = odd + (float)input;
            oddCount = oddCount + 1.0;
        } else if(sum == 0){
            even = even + (float)input;
            evenCount = evenCount + 1.0;
        }

        inputCount++;
        temp = input;
    }

    float avgEven = even / evenCount;
    float avgOdd = odd / oddCount;

    if(evenCount == 0 && oddCount == 0){
        printf("There is no average to compute. \n");
    } else if(oddCount == 0){
        printf("Average of inputs whose digits sum up to be an even number: %.2f\n", avgEven);
    } else if(evenCount == 0){
        printf("Average of inputs whose digits sum up to be an odd number: %.2f\n", avgOdd);
    } else {
        printf("Average of inputs whose digits sum up to be an even number: %.2f\n", avgEven);
        printf("Average of inputs whose digits sum up to be an odd number: %.2f\n", avgOdd);
    }

    return 0;
}