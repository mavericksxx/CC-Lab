#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define MAX_VARS 100
#define MAX_LINE_LENGTH 256

typedef struct {
    char name[50];
} Variable;

Variable variables[MAX_VARS];
int var_count = 0;

void add_variable(const char *name) {
    if (strcmp(name, "eax") == 0 || strcmp(name, "nil") == 0) return;
    
    for (int i = 0; i < var_count; i++) {
        if (strcmp(variables[i].name, name) == 0) return;
    }
    
    if (var_count < MAX_VARS) {
        strncpy(variables[var_count].name, name, sizeof(variables[var_count].name) - 1);
        variables[var_count].name[49] = '\0';
        var_count++;
    }
}

int is_number(const char *s) {
    if (!s || *s == '\0') return 0;
    while (*s) {
        if (!isdigit(*s)) return 0;
        s++;
    }
    return 1;
}

int main() {
    FILE *in = fopen("quad.in", "r");
    FILE *out = fopen("quad.s", "w");
    if (!in || !out) {
        perror("Error");
        return 1;
    }

    char line[MAX_LINE_LENGTH];
    while (fgets(line, sizeof(line), in)) {
        char op[10], op1[50], op2[50], res[50];
        if (sscanf(line, "%s %s %s %s", op, op1, op2, res) != 4) continue;

        if (is_number(op1)) add_variable(res);
        else if (strcmp(op1, "nil")) add_variable(op1);
        
        if (strcmp(res, "nil") && !is_number(res)) add_variable(res);
    }

    rewind(in);

    fprintf(out, ".section .data\nmsg: .string \"Final result of LHS var = %%d\\n\"\n\n");
    fprintf(out, ".section .bss\n");
    for (int i = 0; i < var_count; i++) {
        fprintf(out, ".lcomm %s, 4\n", variables[i].name);
    }
    fprintf(out, "\n.section .text\n.globl main\nmain:\n");
    fprintf(out, "    pushq %%rbp\n    movq %%rsp, %%rbp\n\n");

    while (fgets(line, sizeof(line), in)) {
        char op[10], op1[50], op2[50], res[50];
        if (sscanf(line, "%s %s %s %s", op, op1, op2, res) != 4) continue;

        if (strcmp(op, "=") == 0) {
            if (strcmp(res, "eax") == 0) {
                if (is_number(op1)) {
                    fprintf(out, "    movl $%s, %%eax\n", op1);
                } else {
                    fprintf(out, "    movl %s(%%rip), %%eax\n", op1);
                }
            } else {
                if (is_number(op1)) {
                    fprintf(out, "    movl $%s, %s(%%rip)\n", op1, res);
                } else if (strcmp(op1, "eax") == 0) {
                    fprintf(out, "    movl %%eax, %s(%%rip)\n", res);
                } else {
                    fprintf(out, "    movl %s(%%rip), %%eax\n    movl %%eax, %s(%%rip)\n", 
                            op1, res);
                }
            }
        } 
        else if (strcmp(op, "+") == 0) {
            fprintf(out, "    addl %s(%%rip), %%eax\n", op1);
        }
    }

    fprintf(out, "\n    movl z(%%rip), %%esi\n    leaq msg(%%rip), %%rdi\n");
    fprintf(out, "    movl $0, %%eax\n    call printf\n\n");
    fprintf(out, "    movl $0, %%eax\n    popq %%rbp\n    ret\n");

    fclose(in);
    fclose(out);
    return 0;
}