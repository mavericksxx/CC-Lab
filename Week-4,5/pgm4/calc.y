%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <math.h>
    int yylex(void);
    void yyerror(char *);  
%} 
    %token INTEGER PLUS MINUS MUL DIV LP RP NL
    %left PLUS MINUS 
    %left MUL DIV
    %right POWER
    %right UMINUS
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
| expr POWER expr { $$ = pow($1, $3); }
| MINUS expr %prec UMINUS { $$ = -$2; }
| LP expr RP { $$ = $2; }
;

%%
void yyerror(char *s) 
{
    printf("Error: %s\n", s);
}

int main() 
{
    printf("Mini calculator (supports +, -, *, /, ^, and negative nos.)\n");
    printf("Enter expressions (CTRL + D) to exit\n");
    yyparse();
    return 0;
}
