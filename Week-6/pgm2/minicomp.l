%{
   #include "y.tab.h"
   #include <stdio.h>
   #include <stdlib.h>
%}

%%
"float"                    { return FLOAT; }
"double"                   { return DOUBLE; }
"char"                     { return CHAR; }

"if"                       { printf("Error: 'if' used as variable name\n"); exit(1); }
"while"                    { printf("Error: 'while' used as variable name\n"); exit(1); }
"do"                       { printf("Error: 'do' used as variable name\n"); exit(1); }
"for"                      { printf("Error: 'for' used as variable name\n"); exit(1); }

"#include <stdio.h>"        { return HEADER; }
"int"                      { return INT; }
"main"                     { return MAIN; }
"("                        { return LB; }
")"                        { return RB; }
"{"                        { return LCB; }
"}"                        { return RCB; }
","                        { return COMA; }
";"                        { return SC; }
"="                        { return EQ; }
"+"                        { return PLUS; }
"-"                        { return MINUS; }
"*"                        { return MUL; }
"/"                        { return DIV; }
[A-Za-z][A-Za-z0-9_]*      { return VAR; }
[ \t\n]+                   
.                          { printf("Error: Invalid character '%c'\n", yytext[0]); exit(1); }

%%

int yywrap() {
   return 1;
}