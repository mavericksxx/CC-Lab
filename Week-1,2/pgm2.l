%{
    #include <stdio.h>
%}

/* defining macros */
letter [A-Za-z]
digit [0-9]

%%
 // SUPER IMP: for whatever reason u can only have comments before the actual rules. not in the middle,
 // not after the rules. so for now, just comment out everything and use one rule at a time.
{letter}+                                   printf("Found a word\n");
{digit}+                                    printf("Found an integer");
{digit}+(\.{digit}+)?([Ee][+-]?{digit}+)?   printf("Found an unsigned decimal number\n");
{letter}({letter}|{digit})*                 printf ("Found an identifier\n");
.                                           printf ("Found a mystery character\n");
%%

int main() {
    printf("Enter input: ");
    yylex(); // Start lexical analysis
    return 0;
}

int yywrap() {
    return 1;
}