// This is an open source non-commercial project. Dear PVS-Studio, please check it.
// PVS-Studio Static Code Analyzer for C, C++ and C#: http://www.viva64.com
/*
 * @description
 * CWE: 369 Divide by Zero
 */

#include "369.h"

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

static int staticReturnsTrue()
{
    return 1;
}

static int staticReturnsFalse()
{
    return 0;
}

/* The variable below is declared "const", so a tool should be able
   to identify that reads of this will always give its initialized
   value. */
static const int STATIC_CONST_FIVE = 5;

#ifndef OMITBAD

void bad8()
{
    int data;
    /* Initialize data */
    data = -1;
    if(staticReturnsTrue())
    {
        /* POTENTIAL FLAW: Read data from the console using fscanf() */
        fscanf(stdin, "%d", &data);
    }
    if(staticReturnsTrue())
    {
        /* POTENTIAL FLAW: Possibly divide by zero */
        printIntLine(100 / data);
    }
}

#endif /* OMITBAD */


void good8()
{
    int data;
    /* Initialize data */
    data = -1;
    if(staticReturnsTrue())
    {
        /* POTENTIAL FLAW: Read data from the console using fscanf() */
        fscanf(stdin, "%d", &data);
    }
    if(staticReturnsFalse())
    {
        /* INCIDENTAL: CWE 561 Dead Code, the code below will never run */
        printLine("Benign, fixed string");
    }
    else
    {
        /* FIX: test for a zero denominator */
        if( data != 0 )
        {
            printIntLine(100 / data);
        }
        else
        {
            printLine("This would result in a divide by zero");
        }
    }
}


int main(){
	bad8();
	good8();
    return 1;
}