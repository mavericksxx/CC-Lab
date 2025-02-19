%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    
    char number[100];
    int valid = 1;
%}

%%
[0-9]+      { strcpy(number, yytext); }
[ \t\n]     ; /* Skip whitespace */
.           { valid = 0; }
%%

int main()
{
    printf("Enter a number: ");
    yylex();
    
    if (!valid) {
        printf("Invalid input! Please enter only numbers.\n");
        return 1;
    }
    
    long num = atol(number);  // Using long for larger numbers
    int length = strlen(number);
    
    printf("Length of number: %d\n", length);
    
    if (num % 2 == 0) {
        printf("%ld is an even number\n", num);
    } else {
        printf("%ld is an odd number\n", num);
    }
    
    return 0;
}

int yywrap()
{
    return 1;
}