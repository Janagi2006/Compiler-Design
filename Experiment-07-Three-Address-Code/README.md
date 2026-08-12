# Experiment 07 - Three Address Code

## Aim
To generate intermediate Three-Address Code (TAC) for a simple arithmetic assignment statement using LEX and YACC tools.

## Algorithm
### LEX Specification (`tac.l`):
1. Identify identifier lexemes (`[a-zA-Z_][a-zA-Z0-9_]*`) and copy string value into `yylval.str`, returning `ID`.
2. Identify numeric constants (`[0-9]+`) and copy into `yylval.str`, returning `NUM`.
3. Return operators (`+`, `-`, `*`, `/`, `=`) and ignore whitespaces.

### YACC Grammar (`tac.y`):
1. Define `%typedef struct { char str[32]; } YYSTYPE`.
2. Maintain a global counter `tempCount` for temporary variable generation (`t1`, `t2`, ...).
3. On matching arithmetic operator productions (`expr '+' expr`, `expr '*' expr`, etc.), allocate temporary variable `tN`, print quad/triplet intermediate code line (`tN = op1 op op2`), and propagate `tN` up the parse tree.
4. On assignment rule `ID '=' expr`, print final assignment `ID = expr`.

## Files
- `tac.l`: LEX specification tokenizing assignment expressions.
- `tac.y`: YACC specification generating Three-Address Code instructions.
- `sample_input.txt`: Test input assignment expression.
- `output.txt`: Captured terminal output log.

## Requirements
- GCC Compiler (`gcc`)
- Flex Lexical Analyzer (`flex`)
- Bison Parser Generator (`bison`)

## Compilation
```bash
bison -d tac.y
flex tac.l
gcc tac.tab.c lex.yy.c -o tac
```

## Execution
```bash
./tac < sample_input.txt
```

## Sample Input
```text
a = b + c * d
```

## Sample Output
```text
Enter expression (e.g., a = b + c * d):
t1 = c * d
t2 = b + t1
a = t2
```

## Result
The Three-Address Code generator using LEX and YACC was successfully implemented and verified.
