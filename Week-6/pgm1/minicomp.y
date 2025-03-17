%{
    #include <stdio.h>
    #include <stdlib.h>
    void yyerror(const char *s);
    int yylex(void);
%}

%token HEADER INT MAIN LB RB LCB RCB VAR COMMA SC

%%
PGM: HEADER INT MAIN LB RB LCB BODY RCB
{
    printf("Valid Program recognized\n");
};

BODY:
DECL_STMTS ;
DECL_STMTS: DECL_STMT DECL_STMTS | DECL_STMT;
DECL_STMT: INT VAR_LIST SC {printf("Declaration statement recognized\n");};
VAR_LIST: VAR COMMA VAR_LIST | VAR;
%%

void yyerror(const char *s)
{
    printf("Error: %s\n", s);
}

int main()
{
    printf("Enter C program template with declarations\n");
    yyparse();
    return 0;
}