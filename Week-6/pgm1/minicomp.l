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
[a-z]*                     { return VAR; }
[ \t\n]+                   ;
.                          { printf("invalid character: %s\n", yytext); }
%%