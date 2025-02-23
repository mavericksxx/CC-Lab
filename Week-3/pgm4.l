%{
int flag=0;
#include <stdio.h>
#include <stdlib.h>
%}

even_no [0-9]*[0|2|4|6|8]
odd_no [0-9]*[1|3|5|7|9]

%%
{even_no} {printf("Even number of length %d\n", yyleng); flag = 1; 
            return atoi(yytext);}
{odd_no} {printf("Odd number of length %d\n", yyleng); 
            return atoi(yytext);}
%%

int main() 
{
    int a, b, diff, f1=0;
    printf("\nInput an even number and an odd number\n");
    a = yylex();
    if (flag == 1)
        f1 = 1;
    b = yylex();
    diff = a - b;
    //printf("%d\n%d\n%d\n", a, b, (a - b));
    if (diff%2 != 0 && f1)
        printf("\nYour inputs were checked for correctness. \nResult : Correct\n");
    else
        printf("\nYour inputs were checked for correctness. \nResult : Incorrect\n");
    return 1;
}