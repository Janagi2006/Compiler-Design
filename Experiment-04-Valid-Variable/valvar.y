%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);
%}

%token LET DIG

%%

input:
    /* empty */
    | input line
    ;

line:
    '\n'
    | variable '\n' { printf("Valid variable\n\n"); }
    ;

variable:
    LET rest
    ;

rest:
    /* empty */
    | rest LET
    | rest DIG
    ;

%%

void yyerror(const char *s) {
    printf("Invalid variable\n\n");
}

int main() {
    printf("Enter variable name(s):\n");
    yyparse();
    return 0;
}
