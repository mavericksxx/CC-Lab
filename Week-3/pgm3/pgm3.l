%{
    #include <stdio.h>
    #include <stdlib.h>

    int num_chars = 0;
    int num_words = 0;
%}

%%
[a-zA-Z]+   { if(yyleng >= 6) {
                num_words++; 
                num_chars += yyleng;
              }
            }
[ \t\n]     { num_chars++; }
.           { num_chars++; }

%%

int main()
{
    printf("Enter text: \n");
    yylex();
    
    printf("Number of words (length >= 6): %d\n", num_words);
    printf("Number of characters in words (length >= 6): %d\n", num_chars);
    
    return 0;
}

int yywrap()
{
    return 1;
}