#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

void generateAssembly(const char line[]) {
    char result[16], op1[16], op2[16], operator;
    int matched = sscanf(line, "%s = %s %c %s", result, op1, &operator, op2);

    if (matched == 4) {
        // Arithmetic operation
        printf("MOV AX, %s\n", op1);
        switch (operator) {
            case '+':
                printf("ADD AX, %s\n", op2);
                break;
            case '-':
                printf("SUB AX, %s\n", op2);
                break;
            case '*':
                printf("MUL %s\n", op2);
                break;
            case '/':
                printf("MOV DX, 0\n");
                printf("MOV BX, %s\n", op2);
                printf("DIV BX\n");
                break;
        }
        printf("MOV %s, AX\n\n", result);
    } else {
        // Simple assignment: x = y
        char var1[16], var2[16];
        if (sscanf(line, "%s = %s", var1, var2) == 2) {
            printf("MOV AX, %s\n", var2);
            printf("MOV %s, AX\n\n", var1);
        }
    }
}

int main() {
    char tac[10][100] = {
        "t1 = a + b",
        "t2 = t1 - c",
        "t3 = t2 * d",
        "t4 = t3 / e",
        "x = t4"
    };
    int n = 5;

    printf("================ 8086 CODE GENERATOR ================\n");
    printf("Input Three-Address Code (%d lines):\n", n);
    for (int i = 0; i < n; i++) {
        printf("  %s\n", tac[i]);
    }

    printf("\nGenerated 8086 Assembly Code:\n\n");
    for (int i = 0; i < n; i++) {
        generateAssembly(tac[i]);
    }
    printf("=====================================================\n");

    return 0;
}
