#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

struct Symbol {
    char var[32];
    char dt[16];
};

struct Symbol tbl[50];
int symCount = 0;

int searchSymbol(const char* name) {
    for (int i = 0; i < symCount; i++) {
        if (strcmp(tbl[i].var, name) == 0) return i;
    }
    return -1;
}

int isValidDatatype(const char* dt) {
    return (strcmp(dt, "int") == 0 || strcmp(dt, "float") == 0 ||
            strcmp(dt, "char") == 0 || strcmp(dt, "double") == 0);
}

void addDeclaration(const char* declaration) {
    char datatype[16], varname[32];
    if (sscanf(declaration, "%s %[^;];", datatype, varname) == 2) {
        if (!isValidDatatype(datatype)) {
            printf("Invalid datatype: %s\n", datatype);
            return;
        }
        if (searchSymbol(varname) != -1) {
            printf("Error: Variable '%s' is already declared\n", varname);
            return;
        }
        strcpy(tbl[symCount].dt, datatype);
        strcpy(tbl[symCount].var, varname);
        symCount++;
    }
}

void performTypeCheck(const char* expression) {
    char result[32], op1[32], op2[32], operator;
    int items = sscanf(expression, "%s = %s %c %[^;];", result, op1, &operator, op2);
    
    if (items < 2) return;

    int rIndex = searchSymbol(result);
    if (rIndex == -1) {
        printf("Semantic Error: Undefined variable '%s'\n", result);
        return;
    }

    if (items == 2) {
        // Simple assignment: x = y;
        int o1Index = searchSymbol(op1);
        if (o1Index == -1 && !isdigit(op1[0])) {
            printf("Semantic Error: Undefined variable '%s'\n", op1);
            return;
        }
        if (o1Index != -1 && strcmp(tbl[rIndex].dt, tbl[o1Index].dt) != 0) {
            printf("Type Mismatch: Cannot assign '%s' (%s) to '%s' (%s)\n",
                   op1, tbl[o1Index].dt, result, tbl[rIndex].dt);
        } else {
            printf("No type mismatch in expression: %s", expression);
        }
        return;
    }

    int o1Index = searchSymbol(op1);
    int o2Index = searchSymbol(op2);

    if (o1Index == -1 && !isdigit(op1[0])) {
        printf("Semantic Error: Undefined variable '%s'\n", op1);
        return;
    }
    if (o2Index == -1 && !isdigit(op2[0])) {
        printf("Semantic Error: Undefined variable '%s'\n", op2);
        return;
    }

    char op1Type[16], op2Type[16];
    strcpy(op1Type, (o1Index != -1) ? tbl[o1Index].dt : "int");
    strcpy(op2Type, (o2Index != -1) ? tbl[o2Index].dt : "int");

    if (strcmp(op1Type, op2Type) != 0) {
        printf("Type Mismatch between operands '%s' (%s) and '%s' (%s) in '%s'\n",
               op1, op1Type, op2, op2Type, expression);
    } else if (strcmp(tbl[rIndex].dt, op1Type) != 0) {
        printf("Type Mismatch: Lvalue '%s' (%s) and Rvalue expression (%s) must match in '%s'\n",
               result, tbl[rIndex].dt, op1Type, expression);
    } else {
        printf("There is no type mismatch in the expression %s", expression);
    }
}

int main() {
    printf("IMPLEMENTATION OF TYPE CHECKING\n\n");

    addDeclaration("int a;");
    addDeclaration("int b;");
    addDeclaration("int c;");
    addDeclaration("float d;");

    printf("SYMBOL TABLE DECLARATIONS:\n");
    for (int i = 0; i < symCount; i++) {
        printf("  %-10s %s;\n", tbl[i].dt, tbl[i].var);
    }

    printf("\nSEMANTIC ANALYZER (TYPE CHECKING):\n");

    printf("\nTest Case 1:\n");
    performTypeCheck("a = b * c;\n");

    printf("\nTest Case 2:\n");
    performTypeCheck("a = b + d;\n");

    return 0;
}
