%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);
%}

%token ID DIG
%left '+' '-'
%left '*' '/'
%right UMINUS

%%

input:
    /* empty */
    | input line
    ;

line:
    '\n'
    | expn '\n' { printf("Valid Expression\n\n"); }
    ;

expn:
    expn '+' expn
    | expn '-' expn
    | expn '*' expn
    | expn '/' expn
    | '-' expn %prec UMINUS
    | '(' expn ')'
    | DIG
    | ID
    ;

%%

void yyerror(const char *s) {
    printf("Invalid Expression\n\n");
}

int main() {
    printf("Enter Arithmetic Expression(s):\n");
    yyparse();
    return 0;
}
