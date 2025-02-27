%{
    #include <stdio.h>
    void yyerror(char *);
    #include "y.tab.h"
%}

%%
[0-9]+ { yylval = atoi(yytext); return INTEGER; }
"+" return PLUS;
"-" return MINUS;
[\n] return NL;
[ \t] ; /* skip */
. printf("invalid character");
%%

int yywrap(void) {
    return 1;
}