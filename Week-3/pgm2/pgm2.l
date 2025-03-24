%{
    #include <stdio.h>
    #include <stdlib.h>

    int num_chars = 0;
    int num_words = 0;
%}

%%
[a-zA-Z]+   { num_words++; 
              num_chars += yyleng; }
[ \t\n]     { num_chars++; }
.           { num_chars++; }

%%

int main()
{
    printf("Enter text: \n");
    yylex();
    
    printf("Number of words: %d\n", num_words);
    printf("Number of characters: %d\n", num_chars);
    
    return 0;
}

int yywrap()
{
    return 1;
}