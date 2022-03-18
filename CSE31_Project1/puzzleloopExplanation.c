    // set size to the length of the word
    wordSize = strlen(word);    

    // Check if the first letter is found or not. This 'if' statement will ensure that the number of words found so far is 0.
    // Since it's 0, that means we are trying to find the first letter in the word. 
    if(wordNum == 0){
        // Nested for loop to traverse the array to find the first letter in the word

        /* 
            General 'for' loop that will have an index 'i' and will keep looping as long as i is less than 'bSize'
        */
        for(){
            /* 
                General 'for' loop that will have an index 'j' and will keep looping as long as j is less than 'bSize'
            */
            for(){
                /* 
                    'if' statment that checks if the current character we are looking at is the one we are searching for
                */
                if(){
                    // increment the wordNum if we find the first letter
                    wordNum++;

                    // Recursion of the puzzleLoop function begins inside the if statement
                    /*  
                        Remember what recursion is like, we reuse the function, so for example: puzzleLoop(arr, word, i, j).
                        Check to see if the function is equal to 1
                    */
                    if((){

                        /* 
                            Difficult to wrap around the below line, but essentially it does some math that generates double or 
                            even triple digits if it finds multiple paths (as I understood it)
                        */
                        *(*(finishedArr + i) + j) = *(*(finishedArr + i) + j) * 10 + wordNum; 

                        /* 
                            Decrement wordNum, since if you reach this point, wordNum will most likely be greater than the word 
                            size. An example is the following: HELLO consists of 5 characters. But our wordNum says we have 6
                            characters. The decrement ensures we have the right value for wordNum
                        */
                        wordNum--;

                        /*  
                            Set 'result' to 1, since reaching this point of the code means we found the entire word inside the 
                            puzzle 
                        */
                        result = 1;

                    }
                } 
            }
        }

    // If first letter is found, look for all the other letters in a 3 by 3 square
    } else {
        /*  Nested for loop to traverse the array, but this time it's going to be after the first letter is found.
            The below 'for' loops will traverse the array and look around the first letter (that was found) in a 3 by 3
            square
        */
        for(int i = row-1; i <= row+1; i++){
            for(int j = column-1; j <= column+1; j++){

                /*  If the wordNum is greater than or equal to the wordSize. We have found all the letters that we need.
                    Therefore, return a 1 to tell the function that we have found all the letters inside the 2d Array, so 
                    that we can proceed to the next step and resolve the recursion
                */

                if(){
                    return 1;
                }

                /*  Now we need to set bounds. This is the 'if' statement that will ensure you don't go out of bounds and get
                    an error or a segmentation fault. The general list of things you need to do in this 'if' statements
                    is the following: BOTH 'i' and 'j' needs to be greater than or equal to 0; BOTH 'i' and 'j' are the
                    less than the 'bSize'; and 'i' is NOT equal to 'a' (row) AND 'j' is NOT equal to 'b' (column)

                */
                if(){

                }

                    /*
                        If the current letter is what we are looking for, increment the 'wordNum' to tell the program that we have
                        found the next letter that we are looking for. This is a hint for the last bit of this 'if' statement. 
                         __________ == *(word + wordNum) 
                    */
                    if(){
                        wordNum++;

                        /* 
                            Remember what recursion is like, we reuse the function, so for example: puzzleLoop(arr, word, i, j).
                            Check to see if the function is equal to 1
                        */
                        if(){

                            /* 
                                Same thing shown above, we are going to put the below line of code inside this 'if' statement
                                as well
                            */
                            *(*(finishedArr + i) + j) = *(*(finishedArr + i) + j) * 10 + wordNum; 

                            /* 
                                Finish off with what was explained above (decrement wordNum to get correct value and return 1, 
                                which means that we found what we were looking for)
                            */
                            wordNum--;
                            return 1;
                        }
                    }

                }
            }
        }

    }

    /* 
        If the letter isn't found and everything fails, we come to the below statment which basically says "We didn't find the
        letter(s) in the 2d array" 
    */
    wordNum--;
    return -1;
}

    /*
        In the original print array function we see that it prints characters. What we need to do is copy and paste the print function
        to the below function, and swap all the character stuff and change to allow for integers to be printed.
    */
int printIntArray();