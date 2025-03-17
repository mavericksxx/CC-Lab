%{
    #include <stdio.h>
    void yyerror(char *);
    #include "y.tab.h"
%}

%%
"#include <stdio.h>"       { return HEADER; }
"int"                      { return INT; }
"main"                     { return MAIN; }
"("                        { return LB; }
")"                        { return RB; }
"{"                        { return LCB; }
"}"                        { return RCB; }
","                        { return COMMA; }
";"                        { return SC; }
[A-Za-z][A-Za-z0-9_]*      { return VAR; }
[ \t\n]+                   ;
.                          { printf("invalid character: %s\n", yytext); }
%%