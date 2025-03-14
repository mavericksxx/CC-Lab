%{
#include <stdio.h>
#include <stdlib.h>

void print_token(const char* token);
%}

%%
"+"         { print_token("PLUS"); }
"-"         { print_token("MINUS"); }
"*"         { print_token("MUL"); }
"/"         { print_token("DIV"); }
"|"         { print_token("ABS"); }
[0-9]+      { print_token("NUMBER"); }
\n          { print_token("NEW LINE"); }
[ \t]+      { /* Ignore whitespaces */ }
.           { print_token("MYSTERY CHAR"); }
%%

int main()
{
    printf("Enter input: ");
    yylex();
    return 0;
}

void print_token(const char* token)
{
    printf("%s\n", token);
}