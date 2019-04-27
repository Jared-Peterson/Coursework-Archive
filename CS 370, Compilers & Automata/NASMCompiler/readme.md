# NASM Compiler

This is a compiler that takes in C code, and outputs NASM code using LEX, YACC, and C as the backend.

## Prerequisites

Software required to run these files are: LEX, YACC, make (linus command), and C compiler.

## How to Use

How to compile.

```
make
```

Example input.

```
./lab9 -o <outputfile.asm> < <testfile.c>
```

Input with given files.
```
./lab9 -o output.asm < test.c
```
