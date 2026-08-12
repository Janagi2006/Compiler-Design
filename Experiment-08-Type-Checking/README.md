# Experiment 08 - Type Checking

## Aim
To write a C program to implement semantic type checking of variables in arithmetic expressions using a symbol table.

## Algorithm
1. Declare a symbol table structure holding variable names and associated data types (`int`, `float`, `char`, `double`).
2. Read variable declaration statements (e.g., `int a;`, `float d;`) and insert entries into the symbol table.
3. Parse input assignment expressions to extract the result variable (`Lvalue`), first operand, operator, and second operand (`Rvalues`).
4. Lookup all variables in the symbol table:
   - If any variable is undeclared, output `"Semantic Error: Undefined variable"`.
   - If operand types differ (e.g., `int` and `float`), output `"Type Mismatch between operands"`.
   - If `Lvalue` type differs from calculated `Rvalue` expression type, output `"Type Mismatch: Lvalue and Rvalue must match"`.
   - If all data types match consistently, output `"There is no type mismatch in the expression"`.

## Files
- `typecheck.c`: C program source implementing type checking analysis with symbol table.
- `sample_input.txt`: Sample variable declarations and expression test cases.
- `output.txt`: Captured terminal verification log.

## Requirements
- GCC Compiler (`gcc`)

## Compilation
```bash
gcc typecheck.c -o typecheck
```

## Execution
```bash
./typecheck
```

## Sample Input
```text
DECLARATIONS:
int a;
int b;
int c;
float d;

EXPRESSIONS:
a = b * c;
a = b + d;
```

## Sample Output
```text
IMPLEMENTATION OF TYPE CHECKING

SYMBOL TABLE DECLARATIONS:
  int        a;
  int        b;
  int        c;
  float      d;

SEMANTIC ANALYZER (TYPE CHECKING):

Test Case 1:
There is no type mismatch in the expression a = b * c;

Test Case 2:
Type Mismatch between operands 'b' (int) and 'd' (float) in 'a = b + d;'
```

## Result
The C program to implement semantic type checking was successfully built, executed, and verified.
