// This is an open source non-commercial project. Dear PVS-Studio, please check it.
// PVS-Studio Static Code Analyzer for C, C++ and C#: http://www.viva64.com
 /*
 * @description
 * CWE: 415 Double Free
 */

#include "415.h"

const int GLOBAL_CONST_TRUE = 1; /* true */
const int GLOBAL_CONST_FALSE = 0; /* false */
const int GLOBAL_CONST_FIVE = 5; 

int globalTrue = 1; /* true */
int globalFalse = 0; /* false */
int globalFive = 5; 

int globalReturnsTrue() 
{
    return 1;
}

int globalReturnsFalse() 
{
    return 0;
}

int globalReturnsTrueOrFalse() 
{
    return (rand() % 2);
}

void printHexCharLine (char charHex)
{
    printf("%d\n", (int)charHex);
}

void printLine (const char * line)
{
    if(line != NULL) 
    {
        printf("%s\n", line);
    }
}

void printIntLine (int intNumber)
{
    printf("%d\n", intNumber);
}

void printLongLine (int64_t longIntNumber)
{
    printf("%ld\n", longIntNumber);
}


#ifndef OMITBAD

void bad29()
{
    int * data;
    /* Initialize data */
    data = NULL;
    if(GLOBAL_CONST_TRUE)
    {
        data = (int *)malloc(100*sizeof(int));
        if (data == NULL) return;
        /* POTENTIAL FLAW: Free data in the source - the bad sink frees data as well */
        free(data);
    }
    if(GLOBAL_CONST_TRUE)
    {
        /* POTENTIAL FLAW: Possibly freeing memory twice */
        free(data);
    }
}

#endif /* OMITBAD */

#ifndef OMITGOOD

void good29()
{
    int * data;
    /* Initialize data */
    data = NULL;
    if(GLOBAL_CONST_TRUE)
    {
        data = (int *)malloc(100*sizeof(int));
        if (data == NULL) return;
        /* POTENTIAL FLAW: Free data in the source - the bad sink frees data as well */
        free(data);
    }
    if(GLOBAL_CONST_FALSE)
    {
        /* INCIDENTAL: CWE 561 Dead Code, the code below will never run */
        printLine("Benign, fixed string");
    }
    else
    {
        /* do nothing */
        /* FIX: Don't attempt to free the memory */
        ; /* empty statement needed for some flow variants */
    }
}

#endif /* OMITGOOD */

int main(){
    good29();
	bad29();
    return 1;
}