# Lab 8 (Intermediate Code Generation)

In this lab, you are supposed to implement an intermediate code generator that will take an arithmetic expression as input and generate a) Three-address code, b) Quadraples, and c) Triples using lex and yacc. You may use upper case alphabets as temporary variables and may assume no variable name to be uppercase alphabets. Further, every arithmetic equation is of the form var = A_Expn where A_Expn stands for arithmetic expressions composed of +, *, / and - operators alone. Also assume operands to be of single character variable names.
(Note: You can modify your calculator program for implementing this problem)
Example1:a=(b+c )∗( d+e);
Three-address code:
A:=     b       +       c
B:=     d       +       e
C:=     A       *       B
D:=     a       =       C

Quadraple:
+       b       c       A
+       d       e       B
*       A       B       C
=       a       C       D

Triples:
+       b       c
+       d       e
*       pointer0        pointer1
=       a       pointer2
