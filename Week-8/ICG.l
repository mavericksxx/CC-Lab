%{
    #include "y.tab.h"
%}

%%
[a-z]            { yylval.result = strdup(yytext); return VAR; }
"="              { return ASSIGN; }
"+"              { return PLUS; }
"-"              { return MINUS; }
"*"              { return MUL; }
"/"              { return DIV; }
"("              { return LPAREN; }
")"              { return RPAREN; }
[ \t\n]+         ;
.                { return yytext[0]; }

%%

int yywrap() {
    return 1;
}