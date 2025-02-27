# CS F363 - Compiler Construction Lab

## How to compile and run lex programs
1. lex <FILENAME>.l
2. cc lex.yy.c -ll
3. a.out

## How to compile and run yacc programs
1. lex <FILENAME>.l   
    -> creates lex.yy.c
2. yacc -d <FILENAME>.y   
    -> creates y.tab.c & y.tab.h
3. gcc lex.yy.c y.tab.c -ll
3. execute using ./a.out