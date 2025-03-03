# YACC
Works in bottom-up parsing

## Compiling the program
1. lex [FILENAME].l -> creates lex.yy.c
2. yacc -d [FILENAME].y -> creates y.tab.c & y.tab.h
3. gcc lex.yy.c y.tab.c -ll  // gcc lex.yy.c y.tab.c -o [FILENAME] -ll (if you want to name the output file)
3. execute using ./a.out (or [FILENAME] if the file was renamed)

## Explanation
We're working with 2 files, a lex file and a yacc file

### YACC compiler will spew out 2 files:
1. y.tab.c -> will contain the yyparse() function
    yyparse() -> core of the syntax analyzer
              -> calls yylex()
2. y.tab.h -> contains definitions of tokens
    must be included in the lex file

### YACC file (.y)
1. declaration
    %{

    %}

2. %token PLUS MINUS BLABLABLA
    (follows the scheme <token_name, attributes>)

3. rules --> rules of the grammar
    eg.  P: E NL;
         E: E PLUS E
           |E MINUS E
           |INT;

### Built-in variables:
1. yylval -> used to pass value of a token from lex to yacc (link b/w them)
2. yystype

### Symbols
1. $$ -> left side of grammar rule
2. $1 -> first symbol appearing on the right side of grammer rule

### Conflict resolution
1. Shift-reduce conflict ->
2. Reduce-reduce conflict -> if more than one rule derive the same non-terminal (RHS), prefers the first rule in the order
