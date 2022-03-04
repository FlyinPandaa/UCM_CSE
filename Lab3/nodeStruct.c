#include <stdio.h>
#include <stdlib.h>
#include <malloc.h>
struct Node {
    int iValue;
    float fValue;
    struct Node *next;
};
int main() {
    struct Node *head = (struct Node*) malloc(sizeof(struct Node));
    head->iValue = 5;
    head->fValue = 3.14;


    printf("value of head: %p\n", *head);
    printf("address of head: %p\n", &head);

    printf("Value of iValue: %d\n", head->iValue);
    printf("Value of fValue: %f\n", head->fValue);

    printf("Adress of head iValue: %p\n", &head->iValue);
    printf("Adress of head fValue:%p\n", &head->fValue);

    printf("Address of head next: %p\n", &(head->next));

return 0;
}