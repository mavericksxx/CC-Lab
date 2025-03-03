%{
    #include <stdio.h>
    void yyerror(char *);
    #include "y.tab.h"
%}

%%
[0-9]+ { yylval = atoi(yytext); return INTEGER; }
"+" return PLUS;
"-" return MINUS;
"*" return MUL;
"/" return DIV;
"(" return LP;
")" return RP;
[\n] return NL;
[ \t] ; /* skip */
. printf("invalid character");
%%

int yywrap(void) {
    return 1;
}
