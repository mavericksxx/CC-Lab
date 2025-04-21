
# Lab 07 (Implementing C Mini Compiler)

     Implementing Symbol Table & Type checking in program statements

In this exercise, you are already provided with LEX and YACC files in the question folder. You are supposed to incorporate two functions insert_to_table() and lookup_in_table() to your yacc program (prototype of the functions and symbol table data structure are given. You just have to write the body of both functions) so that in each of those program statements, the parser would confirm the following:

Whether all variables in an expression are of the same type. If not, would show up a type mismatch error message (as in file input3.c the error message should be: ‘type mismatch in the expression’).

Is there a variable declared multiple times (show a multiple declaration error message and terminate) (input2.c, the error message should be: ‘multiple declaration of variable vartwo’. This has to be taken care of, in the function insert to table() checking whether the variable is already there in the table, before making an entry.

Is there an undeclared variable (show an undeclared error message and exit) (in input4.c the error message should be: ‘variable varfour undeclared’). The wrapper program partially takes care of it. You just have to implement the lookup in table() function appropriately.

Extras:
The program given above does type checking (for data types int and char), given you implement the functions insert() and lookup() properly. Modify the given program to incorporate the same for float and double data types too.