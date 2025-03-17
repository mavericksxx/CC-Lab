%{
   #include <stdio.h>
   #include <stdlib.h>
   void yyerror(const char *s);
   int yylex();
%}

%token HEADER INT MAIN LB RB LCB RCB COMA SC EQ PLUS MINUS MUL DIV VAR
%token FLOAT DOUBLE CHAR

%left PLUS MINUS
%left MUL DIV

%%
PGM: HEADER INT MAIN LB RB LCB BODY RCB { printf("Valid C program structure\n"); }
    ;

BODY: DECL_STMTS PROG_STMTS
    | DECL_STMTS
    ;

DECL_STMTS: DECL_STMT DECL_STMTS
          | DECL_STMT
          ;

DECL_STMT: INT VAR_LIST SC
         | FLOAT VAR_LIST SC
         | DOUBLE VAR_LIST SC
         | CHAR VAR_LIST SC
         ;

VAR_LIST: VAR COMA VAR_LIST
        | VAR
        ;

PROG_STMTS: PROG_STMT PROG_STMTS
          | PROG_STMT
          ;

PROG_STMT: VAR EQ A_EXPN SC
         ;

A_EXPN: A_EXPN PLUS A_EXPN
      | A_EXPN MINUS A_EXPN
      | A_EXPN MUL A_EXPN
      | A_EXPN DIV A_EXPN
      | LB A_EXPN RB
      | VAR
      ;

%%

int main() {
   printf("Enter a C program:\n");
   yyparse();
   return 0;
}

void yyerror(const char *s) {
   printf("Error: %s\n", s);
   exit(1);
}