# Monday (P1)
Consider the following Context-Free Grammar (CFG)

S → for_stmt\
for_stmt → FOR ‘(’ assign_stmt ‘;’ expr ‘;’ assign_stmt ‘)’ stmt\
assign_stmt → ID ‘=’ NUM\
expr → ID relop NUM\
relop → ‘<’ | ‘>’ | ‘<=’ | ‘>=’ | ‘==’ | ‘!=’\
stmt → ‘{’ stmt_list ‘}’ | assign_stmt ‘;’\
stmt_list → stmt stmt_list | ε\

	1.	Write a Lex program to tokenize the input for the above grammar. Handle keywords (for), identifiers, numbers, relational operators, assignment operator, semicolons, parentheses, and braces.
	2.	Write a Yacc program to:
	•	Parse the input using the CFG above.
	•	Check whether a given input string is syntactically valid according to the grammar.
	•	If valid, print “Valid for loop”; otherwise, print “Syntax Error.”
	3.	Extend your Yacc code to generate triplets (3-address code) for the valid for loop construct. Use a triplet format like: (op, arg1, arg2)

## Example
Sample input:\
for(i=0; i<10; i=i+1) { j=2; k=k+3; }

Expected output:\
Valid for loop (=, i, 0) (LABEL, start, ) (<, i, 10) (IF_FALSE_GOTO, (<, i, 10), end) (=, j, 2)
