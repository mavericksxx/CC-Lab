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
        printf("Error: unable to open file 'input'");
        return 1;
        }

    yyin = file; //set lex input to file
    yylex();

    fclose(file);
    return 0;
}

void display (int num, int length) {
    printf("Found number %d whose length is %d\n", num, length);
}