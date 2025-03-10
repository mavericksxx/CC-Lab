%{
    #include <stdio.h>
    #include <math.h>
    #include "y.tab.h"
    #include <ctype.h>
%}

%%
[0-9]+(\.[0-9]+)?   { yylval.dval = atof(yytext); return FLOAT; }
"="                 { return EQ; }
[a-z]               { yylval.var = yytext[0]; return VAR; }
"+"                 { return PLUS; }
"-"                 { return MINUS; }
"*"                 { return MUL; }
"/"                 { return DIV; }
"^"                 { return POWER; }
"("                 { return LP; }
")"                 { return RP; }
[\n]                { return NL; }
[ \t] ; 
.                   { printf("Invalid character\n"); }
%%

int yywrap() {
    return 1;
}