%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    int tempVarCount = 0; // Counter for temporary variables
    int pointerCount = 0; // Counter for pointers (triples)

    void yyerror(const char *s);
    int yylex(void);

    void generateQuadruple(const char *op, const char *arg1, const char *arg2, const char *result);
    void generateTriple(const char *op, const char *arg1, const char *arg2);
%}

%union {
    char *result; // Result variable
}

%token <result> VAR
%token ASSIGN PLUS MINUS MUL DIV LPAREN RPAREN

%type <result> expr term factor

%left PLUS MINUS
%left MUL DIV

%%
stmt: VAR ASSIGN expr
    {
        printf("Three-address code:\n%s := %s\n", $1, $3);
        generateQuadruple("=", $3, "-", $1);
        generateTriple("=", $3, "-");
    }
    ;

expr: expr PLUS term
    {
        $$ = malloc(10);
        sprintf($$, "T%d", tempVarCount++);
        printf("%s := %s + %s\n", $$, $1, $3);
        generateQuadruple("+", $1, $3, $$);
        generateTriple("+", $1, $3);
    }
    | expr MINUS term
    {
        $$ = malloc(10);
        sprintf($$, "T%d", tempVarCount++);
        printf("%s := %s - %s\n", $$, $1, $3);
        generateQuadruple("-", $1, $3, $$);
        generateTriple("-", $1, $3);
    }
    | term
    {
        $$ = strdup($1);
    }
    ;

term: term MUL factor
    {
        $$ = malloc(10);
        sprintf($$, "T%d", tempVarCount++);
        printf("%s := %s * %s\n", $$, $1, $3);
        generateQuadruple("*", $1, $3, $$);
        generateTriple("*", $1, $3);
    }
    | term DIV factor
    {
        $$ = malloc(10);
        sprintf($$, "T%d", tempVarCount++);
        printf("%s := %s / %s\n", $$, $1, $3);
        generateQuadruple("/", $1, $3, $$);
        generateTriple("/", $1, $3);
    }
    | factor
    {
        $$ = strdup($1);
    }
    ;

factor: LPAREN expr RPAREN
    {
        $$ = strdup($2);
    }
    | VAR
    {
        $$ = strdup($1); // Use the value passed from Lex
    }
    ;
%%

void generateQuadruple(const char *op, const char *arg1, const char *arg2, const char *result) {
    printf("Quadruple: %s\t%s\t%s\t%s\n", op, arg1, arg2, result);
}

void generateTriple(const char *op, const char *arg1, const char *arg2) {
    printf("Triple: %s\t%s\t%s\n", op, arg1, arg2);
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter an arithmetic expression:\n");
    yyparse();
    return 0;
}