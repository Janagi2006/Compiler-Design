%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct SymbolEntry {
    char name[32];
    char type[16];
    int address;
};

struct SymbolEntry symtab[100];
int symCount = 0;

int searchSymbol(const char* name) {
    for (int i = 0; i < symCount; i++) {
        if (strcmp(symtab[i].name, name) == 0) return i;
    }
    return -1;
}

void insertSymbol(const char* name, const char* type) {
    if (searchSymbol(name) == -1) {
        strcpy(symtab[symCount].name, name);
        strcpy(symtab[symCount].type, type);
        symtab[symCount].address = 1000 + (symCount * 4);
        symCount++;
    }
}

void displaySymbolTable() {
    printf("\n================ SYMBOL TABLE ================\n");
    printf("%-5s %-20s %-15s %-10s\n", "Index", "Identifier Name", "Type", "Address");
    printf("----------------------------------------------\n");
    for (int i = 0; i < symCount; i++) {
        printf("%-5d %-20s %-15s %-10d\n", i + 1, symtab[i].name, symtab[i].type, symtab[i].address);
    }
    printf("==============================================\n");
}
%}

%option noyywrap

%%

"/*"([^*]|\*+[^/*])*\*+"/"    { printf("[COMMENT]     : %s\n", yytext); }
"//".*                        { printf("[COMMENT]     : %s\n", yytext); }

"int"|"float"|"char"|"double"|"void"|"return"|"if"|"else"|"while"|"for"  { 
    printf("[KEYWORD]     : %s\n", yytext); 
}

[a-zA-Z_][a-zA-Z0-9_]*        { 
    printf("[IDENTIFIER]  : %s\n", yytext); 
    insertSymbol(yytext, "identifier");
}

[0-9]+(\.[0-9]+)?             { printf("[CONSTANT]    : %s\n", yytext); }

"+"|"-"|"*"|"/"|"="|"=="|"<"|">"|"<="|">="|"!="  { printf("[OPERATOR]    : %s\n", yytext); }

"{"|"}"|"("|")"|"["|"]"|";"|","                 { printf("[DELIMITER]   : %s\n", yytext); }

[ \t\n]+                      { /* ignore whitespace */ }

.                             { printf("[UNKNOWN]     : %s\n", yytext); }

%%

int main(int argc, char** argv) {
    if (argc > 1) {
        FILE* fp = fopen(argv[1], "r");
        if (!fp) {
            printf("Error opening file %s\n", argv[1]);
            return 1;
        }
        yyin = fp;
    }
    printf("--- LEXICAL ANALYSIS OUTPUT ---\n");
    yylex();
    displaySymbolTable();
    return 0;
}
