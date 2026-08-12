# Experiment 10 - 8086 Code Generation

## Aim
To implement the back-end of a compiler that translates intermediate Three-Address Code (TAC) statements into target 8086 assembly language instructions.

## Algorithm
1. Read lines of intermediate Three-Address Code (TAC) from input.
2. For each line, parse the left-hand side target variable, operands, and operation operator (`+`, `-`, `*`, `/`, `=`).
3. Map each intermediate TAC operation to target 8086 CPU assembly instructions:
   - **Addition (`a + b`)**:
     `MOV AX, a` -> `ADD AX, b` -> `MOV t1, AX`
   - **Subtraction (`t1 - c`)**:
     `MOV AX, t1` -> `SUB AX, c` -> `MOV t2, AX`
   - **Multiplication (`t2 * d`)**:
     `MOV AX, t2` -> `MUL d` -> `MOV t3, AX`
   - **Division (`t3 / e`)**:
     `MOV AX, t3` -> `MOV DX, 0` -> `MOV BX, e` -> `DIV BX` -> `MOV t4, AX`
   - **Assignment (`x = t4`)**:
     `MOV AX, t4` -> `MOV x, AX`
4. Output the generated 8086 assembly code block.

## Files
- `codegen8086.c`: C program source performing target 8086 assembly code generation.
- `sample_input.txt`: Input intermediate TAC lines file.
- `output.txt`: Captured terminal verification log.

## Requirements
- GCC Compiler (`gcc`)

## Compilation
```bash
gcc codegen8086.c -o codegen8086
```

## Execution
```bash
./codegen8086
```

## Sample Input
```text
5
t1 = a + b
t2 = t1 - c
t3 = t2 * d
t4 = t3 / e
x = t4
```

## Sample Output
```text
================ 8086 CODE GENERATOR ================
Input Three-Address Code (5 lines):
  t1 = a + b
  t2 = t1 - c
  t3 = t2 * d
  t4 = t3 / e
  x = t4

Generated 8086 Assembly Code:

MOV AX, a
ADD AX, b
MOV t1, AX

MOV AX, t1
SUB AX, c
MOV t2, AX

MOV AX, t2
MUL d
MOV t3, AX

MOV AX, t3
MOV DX, 0
MOV BX, e
DIV BX
MOV t4, AX

MOV AX, t4
MOV x, AX

=====================================================
```

## Result
The compiler back-end generating 8086 assembly code from intermediate Three-Address Code was successfully implemented and verified.
