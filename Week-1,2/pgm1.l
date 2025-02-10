%{
    #include <stdio.h>
%}

%%
 // SUPER IMP: for whatever reason u can only have comments before the actual rules. not in the middle,
 // not after the rules. so for now, just comment out everything and use one rule at a time.
 //
 //[abc\-] printf("Found a or b or c or -\n");
 //a|b|c printf("Found a or b or c\n");
 //[a-z]+ printf("Found a word\n");
 //[abc] printf("Found a or b or c\n");
 //[^ghi] printf("Found something other than g and m\n");
[m-q] printf("Found something from m to q\n");
%%

int main() {
    printf("Enter input: ");
    yylex(); // Start lexical analysis
    return 0;
}

int yywrap() {
    return 1;
}