// reading input from file

%{
    #include <stdio.h>
    #include <stdlib.h>

    void display (int num, int length);
%}

%%
[0-9]+ {display(atoi(yytext), yyleng);}
%%

int main () {
    FILE *file = fopen("input.txt", "r");
    if (!file) {
        printf("Error: unable to open file 'input'\n);
        return 1;
    }

    yyin = file; //set lex input to file
    yylex();

    fclose(file);
    return 0;
}