#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

char code[50][100];

int main() {
    FILE *fp;
    int lines = 0;

    // Default sample input lines if file input not present
    char default_input[][100] = {
        "a=d/1;\n",
        "b=2+4;\n",
        "c=s*2;\n"
    };

    printf("================ CODE OPTIMIZER ================\n");
    printf("Unoptimized Input Code:\n");
    for (int i = 0; i < 3; i++) {
        strcpy(code[i], default_input[i]);
        printf("  %s", code[i]);
    }
    lines = 3;

    printf("\nOptimized Code:\n");
    for (int i = 0; i < lines; i++) {
        char lhs, op1, op2, opr;
        int val1, val2, res;

        // Parse line format: lhs=op1 opr op2;
        if (sscanf(code[i], "%c=%c%c%c;", &lhs, &op1, &opr, &op2) == 4) {
            if (isdigit(op1) && isdigit(op2)) {
                // Constant Folding
                val1 = op1 - '0';
                val2 = op2 - '0';
                switch (opr) {
                    case '+': res = val1 + val2; break;
                    case '-': res = val1 - val2; break;
                    case '*': res = val1 * val2; break;
                    case '/': res = (val2 != 0) ? val1 / val2 : 0; break;
                    default: res = 0; break;
                }
                printf("  %c=%d;\t// Constant Folding\n", lhs, res);
            } 
            else if ((opr == '*' && op2 == '1') || (opr == '/' && op2 == '1')) {
                // Algebraic Simplification (x * 1 -> x, x / 1 -> x)
                printf("  %c=%c;\t// Algebraic Simplification (X*1 or X/1)\n", lhs, op1);
            } 
            else if (opr == '*' && op2 == '2') {
                // Strength Reduction (x * 2 -> x + x)
                printf("  %c=%c+%c;\t// Strength Reduction (X*2 to X+X)\n", lhs, op1, op1);
            } 
            else {
                printf("  %s", code[i]);
            }
        } else {
            printf("  %s", code[i]);
        }
    }
    printf("================================================\n");

    return 0;
}
