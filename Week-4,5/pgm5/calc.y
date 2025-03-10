%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <math.h>
    int yylex(void);
    void yyerror(char *);  

    double sym[26];
%} 

%union {
    double dval;
    char var;
}

%token <dval> FLOAT
%token <var> VAR
%type <dval> stmt expr
%token PLUS MINUS MUL DIV POWER LP RP NL EQ
%left PLUS MINUS
%left MUL DIV
%right POWER
%right UMINUS

%%
program:
    program stmt NL
    | 
    ;

stmt:
    expr { printf("Result: %lf\n", $1); }
    | VAR EQ expr { sym[$1 - 'a'] = $3; }
    ;

expr:
    FLOAT { $$ = $1; }
    | VAR { $$ = sym[$1 - 'a']; }
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