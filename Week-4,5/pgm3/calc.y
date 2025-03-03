%{
    #include <stdio.h>
    #include <stdlib.h>
    int yylex(void);
    void yyerror(char *);  
%} 
    %token INTEGER PLUS MINUS MUL DIV LP RP NL
    %left PLUS MINUS 
    %left MUL DIV
%%

program:
program expr NL { printf("%d\n", $2);} 
|
;
expr:
INTEGER { $$ = $1; } 
| expr PLUS expr { $$ = $1 + $3; }
| expr MINUS expr { $$ = $1 - $3; }
| expr MUL expr { $$ = $1 * $3; }
| expr DIV expr { $$ = $1 / $3; }
| LP expr RP { $$ = $2; }
;

%%
void yyerror(char *s) 
{
    printf("%s\n", s);
}

int main() 
{
    yyparse();
    return 0;
}
