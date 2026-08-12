%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char str[32];
} YYSTYPE_STRUCT;

#define YYSTYPE YYSTYPE_STRUCT

int tempCount = 1;
char temp[32];

void printTAC(char* result, char* op1, char* operator, char* op2) {
    printf("%s = %s %s %s\n", result, op1, operator, op2);
}

void printAssign(char* var, char* val) {
    printf("%s = %s\n", var, val);
}

void yyerror(const char* s);
int yylex(void);
%}

%token ID NUM
%left '+' '-'
%left '*' '/'

%%

stmt:
    ID '=' expr { printAssign($1.str, $3.str); }
    ;

expr:
    expr '+' expr {
        sprintf(temp, "t%d", tempCount++);
        printTAC(temp, $1.str, "+", $3.str);
        strcpy($$.str, temp);
    }
    | expr '-' expr {
        sprintf(temp, "t%d", tempCount++);
        printTAC(temp, $1.str, "-", $3.str);
        strcpy($$.str, temp);
    }
    | expr '*' expr {
        sprintf(temp, "t%d", tempCount++);
        printTAC(temp, $1.str, "*", $3.str);
        strcpy($$.str, temp);
    }
    | expr '/' expr {
        sprintf(temp, "t%d", tempCount++);
        printTAC(temp, $1.str, "/", $3.str);
        strcpy($$.str, temp);
    }
    | '(' expr ')' {
        strcpy($$.str, $2.str);
    }
    | ID { strcpy($$.str, $1.str); }
    | NUM { strcpy($$.str, $1.str); }
    ;

%%

void yyerror(const char* s) {
    printf("Error in TAC generation: %s\n", s);
}

int main() {
    printf("Enter expression (e.g., a = b + c * d):\n");
    yyparse();
    return 0;
}
