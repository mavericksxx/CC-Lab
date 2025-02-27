# Compiler Construction
# Lab 04 & 05 (Familiarizing YACC)

1. Understand the working of LEX and YACC using a simple calculator application. Your calculator should provide arithmetic operators + and - that can add or subtract integers respectively (once). Start off with a grammar (not perfect).
Program 🡪 E \n
E 🡪 E + E | E - E | int
The problems with the above grammar – ambiguity. Associativity is not considered. Understand the conflicts in bottom up parsing and YACC’s default action when there is a conflict.

2. Modify your program to take care of associativity of the operators using directives in YACC. + and – are left associative. Also modify the grammar so the calculator application runs until the user quits using <CTRL + D>. Understand YACC’s action in case of shift reduce conflict when associativity and precedence are specified

3. Extend the calculator to incorporate some new functionality. New features include arithmetic operators * and / that can multiply and divide integers respectively. Parentheses may be used to over-ride operator precedence. Note * and / operators have higher precedence over + and – operators. Also note that * and / are left associative. Ensure this using directive in YACC. 

4. Extend the calculator to incorporate some new functionality. New features include operators unary minus - and power that can negate and find the power of an integer respectively. Understand %prec. Both unary minus and power are right associative and of highest precedence.

5. Modify the calculator application so that it works for floating point values also.

6. Modify the grammar to allow single-character variables to be specified in assignment statements. The following illustrates sample input and calculator output:
user: 3 * (4 + 5)
calc: 27
user: x = 3 * (4 + 5)
user: y = 5
user: x
calc: 27
user: y
calc: 5
user: x + 2*y
calc: 37

## Steps to run the lex and yacc files
1. You should have two files project.l (lex file) and project.y (yacc  file) along with the input file if any.
2. Run yacc -dv project.y. This should generate the C program for the syntax analyser y.tab.c along with supplementary files y.tab.h and y.output (run ls command and verify whether the files are generated or not).
3. Run lex project.l. This should generate the C program for the lexical analyser lex.yy.c (run ls command and verify whether the file is generated or not).
4. Run gcc -o mini-compiler lex.yy.c y.tab.c -ll to generate the executable.
5. Feed in the input file to your mini-compiler by running ./mini-compiler < input