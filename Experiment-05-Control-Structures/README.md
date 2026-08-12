# Experiment 05 - Control Structures

## Aim
To write a program using LEX and YACC tools to recognize valid C language control structures syntax (such as `if`, `if-else`, `while` loop, `for` loop, and `switch-case`).

## Algorithm
### LEX Specification (`control.l`):
1. Define token patterns for C control keywords: `if`, `else`, `for`, `while`, `switch`, `case`, `default`, `break`.
2. Return tokens for identifiers (`ID`), numeric constants (`NUM`), relational operators (`EQ`, `LE`, `GE`, `LT`, `GT`), assignment (`ASSIGN`), braces (`{`, `}`), parentheses (`(`, `)`), semicolons (`;`), and colons (`:`).
3. Ignore white space and newline characters.

### YACC Grammar (`control.y`):
1. Define productions for valid C control constructs:
   - **If / If-Else**: `IF LPAREN cond RPAREN stmt [ELSE stmt]`
   - **While Loop**: `WHILE LPAREN cond RPAREN stmt`
   - **For Loop**: `FOR LPAREN ID ASSIGN NUM SEMICOLON cond SEMICOLON ID ASSIGN ID RPAREN stmt`
   - **Switch-Case**: `SWITCH LPAREN ID RPAREN LBRACE case_list RBRACE`
2. Parse input control statements.
3. Print `"Valid control structure syntax."` on successful parsing, or invoke `yyerror()` on syntax mismatch.

## Files
- `control.l`: LEX specification tokenizing control keywords and punctuation.
- `control.y`: YACC grammar specification for C control structures.
- `sample_input.c`: Test C file containing control statements.
- `output.txt`: Captured terminal verification log.

## Requirements
- GCC Compiler (`gcc`)
- Flex Lexical Analyzer (`flex`)
- Bison Parser Generator (`bison`)

## Compilation
```bash
bison -d control.y
flex control.l
gcc control.tab.c lex.yy.c -o control
```

## Execution
```bash
./control < sample_input.c
```

## Sample Input
```c
if (x < 5) {
    y = 10;
} else {
    y = 20;
}
while (i < 10) {
    x = 1;
}
for (i = 0; i < 10; i = i) {
    y = 1;
}
switch (ch) {
    case 1:
        x = 5;
        break;
    default:
        x = 0;
}
```

## Sample Output
```text
Enter C control structure syntax:
Valid control structure syntax.
```

## Result
The LEX and YACC program to validate C language control structures syntax was successfully implemented and verified.
