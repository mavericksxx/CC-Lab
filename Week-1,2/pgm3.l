%{
    #include <stdio.h>
    #include <stdlib.h>

    void display (int num, int length);
%}

%%
[0-9]+ {display(atoi(yytext), yyleng);}
%%

void display (int num, int length) {
    printf("Found number %d whose length is %d\n", num, length);
}

int main() {
    printf("Enter input: ");
    yylex(); // call lexer
    return 0;
}

int yywrap() {
    return 1; // indicates end of input
}