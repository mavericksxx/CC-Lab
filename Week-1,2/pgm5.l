%{
    #include <stdio.h>
    #include <stdlib.h>

    int display(int);
%}

%%
[0-9]+ {display(atoi(yytext));}
%%

int main()
{
    yyin = fopen("input","r");
    yyout = fopen("output", "w"); 
    yylex();
}

int display(int a)
{
    fprintf(yyout, "Found number %d whose length is %d",atoi(yytext), yyleng);
}