#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Declarations of the two functions you will implement
// Feel free to declare any helper functions or global variables
void printPuzzle(char** arr);
void searchPuzzle(char** arr, char* word);
int bSize;
int** finishedArr;
int wordSize =0;
int wordNum = 0;
int isFound = 0;

// Main function, DO NOT MODIFY 	
int main(int argc, char **argv) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <puzzle file name>\n", argv[0]);
        return 2;
    }
    int i, j;
    FILE *fptr;

    // Open file for reading puzzle
    fptr = fopen(argv[1], "r");
    if (fptr == NULL) {
        printf("Cannot Open Puzzle File!\n");
        return 0;
    }

    // Read the size of the puzzle block
    fscanf(fptr, "%d\n", &bSize);
    
    // Allocate space for the puzzle block and the word to be searched
    char **block = (char**)malloc(bSize * sizeof(char*));
    char *word = (char*)malloc(20 * sizeof(char));

    // Read puzzle block into 2D arrays
    for(i = 0; i < bSize; i++) {
        *(block + i) = (char*)malloc(bSize * sizeof(char));
        for (j = 0; j < bSize - 1; ++j) {
            fscanf(fptr, "%c ", *(block + i) + j);            
        }
        fscanf(fptr, "%c \n", *(block + i) + j);
    }
    fclose(fptr);

    printf("Enter the word to search: ");
    scanf("%s", word);
    
    // Print out original puzzle grid
    printf("\nPrinting puzzle before search:\n");
    printPuzzle(block);
    
    // Call searchPuzzle to the word in the puzzle
    searchPuzzle(block, word);

    
    
    return 0;
}

void printPuzzle(char** arr) {
	// This function will print out the complete puzzle grid (arr). 
    // It must produce the output in the SAME format as the samples 
    // in the instructions.
    // Your implementation here...
    
    for(int i = 0; i < bSize; i++){
		for(int j = 0; j < bSize; j++){
			printf("%c, ", *(*(arr + i) + j));
		}
		printf("\n");
	}
}

int puzzleLoop(char **arr, char *word, int row, int column){
    //Length of the word
    wordSize = strlen(word);

    // Check if the first letter is found or not
    if(wordNum == 0){
        // Nested for loop to traverse the array, but this time it's going to be after the first letter is found
        for(int i = 0; i < bSize; i++){
            for(int j = 0; j < bSize; j++){
                // 
                if(*(*(arr + i) + j) == *word ){
                    wordNum++;

                    if((puzzleLoop(arr, word, i, j)) == 1){
                        *(*(finishedArr + i) + j) = *(*(finishedArr + i) + j) * 10 + wordNum; 

                        wordNum--;
                        isFound = 1;

                    }
                } 
            }
        }
    // If first letter is found, look for all the other letters in a 3 by 3 square
    } else {
        // Nested for loop to traverse the array, but this time it's going to be after the first letter is found
        for(int i = row-1; i <= row+1; i++){
            for(int j = column-1; j <= column+1; j++){
                if(wordNum >= wordSize){
                    return 1;
                }
                if(i >= 0 && j >= 0 && i < bSize && j < bSize && !(i == row && j == column)){
                    if(*(*(arr + i) + j) == *(word + wordNum)){
                        wordNum++;

                        if(puzzleLoop(arr, word, i, j) == 1){
                            *(*(finishedArr + i) + j) = *(*(finishedArr + i) + j) * 10 + wordNum; 

                            wordNum--;
                            return 1;
                        }
                    }

                }
            }
        }

    }
    wordNum--;
    return -1;
}

void printIntegerArray(int **arr){
    for(int i = 0; i < bSize; i++){
		for(int j = 0; j < bSize; j++){
			printf("%d,    ", *(*(arr + i) + j));
		}
		printf("\n");
	}
}

void searchPuzzle(char** arr, char* word) {
    // This function checks if arr contains the search word. If the 
    // word appears in arr, it will print out a message and the path 
    // as shown in the sample runs. If not found, it will print a 
    // different message as shown in the sample runs.
    // Your implementation here...

    finishedArr = (int**)malloc(bSize * sizeof(int*));
    
    //Creates array and sets everything to 0
	for(int i = 0; i < bSize; i++){
		*(finishedArr + i) = (int*)malloc(bSize * sizeof(int));
		for(int j = 0; j < bSize; j++){
			*(*(finishedArr + i) + j) = 0;
		}
	}

    word = strupr(word);

    puzzleLoop(arr, word, 0, 0);

    // isFound is a global variable that will be set to one when the search is successful
    if(isFound == 1){
        printf("\n");
        printf("Word found\n");
        printf("Printing the result: \n");
        printIntegerArray(finishedArr);
    } else {
        printf("Word not found\n");
    }
}


