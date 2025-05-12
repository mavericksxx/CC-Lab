%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
    int yylex(void);
    int yyerror(const char *s);
    int success = 1;
    int current_data_type;
    int expn_type = -1;
    int temp;
    struct symbol_table {
        char var_name[30];
        int type;
    } var_list[20]; // symbol table to store var names and types
    int var_count = 0; 

    // lookup and insert function declarations
    extern int lookup_in_table(char var[30]); // returns data type of a var, or -1 if undeclared
    extern void insert_to_table(char var[30], int type); // adds var to the symbol table
%}

%union {
    int data_type;
    char var_name[30];
}

%token HEADER MAIN LB RB LCB RCB SC COMA EQ OP
%token<var_name> VAR
%token<data_type> INT CHAR FLOAT DOUBLE

%type<data_type> DATA_TYPE
%start prm

%left OP // left assocociative precedence for ops (this fixed the error)

%%
prm	: HEADER MAIN_TYPE MAIN LB RB LCB BODY RCB {
        printf("\nParsing successful\n");
    }
    ;

BODY	: DECLARATION_STATEMENTS PROGRAM_STATEMENTS
    ;

DECLARATION_STATEMENTS 
    : DECLARATION_STATEMENT DECLARATION_STATEMENTS {
        printf("\nDeclaration section successfully parsed\n");
    }
    | DECLARATION_STATEMENT
    ;

PROGRAM_STATEMENTS 
    : PROGRAM_STATEMENT PROGRAM_STATEMENTS {
        printf("\nProgram statements successfully parsed\n");
    }
    | PROGRAM_STATEMENT
    ;

DECLARATION_STATEMENT 
    : DATA_TYPE VAR_LIST SC {}
    ;

VAR_LIST 
    : VAR {
        insert_to_table($1, current_data_type);
    }
    | VAR COMA VAR_LIST {
        insert_to_table($1, current_data_type);
    }
    ;

PROGRAM_STATEMENT 
    : VAR EQ A_EXPN SC {
        expn_type = -1;
    }
    ;

A_EXPN 
    : A_EXPN OP A_EXPN
    | LB A_EXPN RB
    | VAR {
        if ((temp = lookup_in_table($1)) != -1) {
            if (expn_type == -1) {
                expn_type = temp;
            } else if (expn_type != temp) {
                printf("\nType mismatch in the expression\n");
                exit(0);
            }
        } else {
            printf("\nVariable \"%s\" undeclared\n", $1);
            exit(0);
        }
    }
    ;

MAIN_TYPE 
    : INT
    ;

DATA_TYPE 
    : INT {
        $$ = $1;
        current_data_type = $1;
    }
    | CHAR {
        $$ = $1;
        current_data_type = $1;
    }
    | FLOAT{
        $$ = $1;
        current_data_type = $1;
    }
    | DOUBLE
    ;

%%

// look up a var in the symbol table
int lookup_in_table(char var[30]) {
    for (int i = 0; i < var_count; i++) {
        if (strcmp(var_list[i].var_name, var) == 0) {
            return var_list[i].type;
        }
    }
    return -1; // var not found
}

// insert var into the symbol table
void insert_to_table(char var[30], int type) {
    // check if var already exists
    for (int i = 0; i < var_count; i++) {
        if (strcmp(var_list[i].var_name, var) == 0) {
            printf("Error: Variable \"%s\" already declared\n", var);
            exit(0);
        }
    }

    // add var to the table
    strcpy(var_list[var_count].var_name, var);
    var_list[var_count].type = type;
    var_count++;
}

int main() {
    yyparse();
    return 0;
}

int yyerror(const char *msg) {
    extern int yylineno;
    printf("Parsing Failed\nLine Number: %d: %s\n", yylineno, msg);
    success = 0;
    return 0;
}
