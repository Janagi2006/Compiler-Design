# Experiment 04 - Valid Variable

## Aim
To write a program using LEX and YACC tools to recognize a valid variable name which starts with a letter followed by any number of letters or digits.

## Algorithm
### LEX Specification (`valvar.l`):
1. Match alphabetic characters (`[a-zA-Z]`) and return token `LET`.
2. Match numeric digits (`[0-9]`) and return token `DIG`.
3. Match newline (`\n`) to signal expression end.
4. Ignore spaces and tabs.

### YACC Grammar (`valvar.y`):
1. Declare tokens `LET` and `DIG`.
2. Define grammar productions ensuring variable names begin with `LET`:
   - `variable -> LET rest`
   - `rest -> rest LET | rest DIG | empty`
3. Output `"Valid variable"` on successfully parsing a valid identifier.
4. Output `"Invalid variable"` on syntax or lexeme violation.

## Files
- `valvar.l`: LEX specification file for tokenizing letters and digits.
- `valvar.y`: YACC file defining variable structure syntax rules.
- `sample_input.txt`: Test input file containing valid and invalid variable names.
- `output.txt`: Captured terminal verification log.

## Requirements
- GCC Compiler (`gcc`)
- Flex Lexical Analyzer (`flex`)
- Bison Parser Generator (`bison`)

## Compilation
```bash
bison -d valvar.y
flex valvar.l
gcc valvar.tab.c lex.yy.c -o valvar
```

## Execution
```bash
./valvar < sample_input.txt
```

## Sample Input
```text
var1
a123
123var
x
```

## Sample Output
```text
Enter variable name(s):
var1
Valid variable

a123
Valid variable

123var
Invalid variable

x
Valid variable
```

## Result
The LEX and YACC program to recognize valid C variable names was successfully implemented and verified.
