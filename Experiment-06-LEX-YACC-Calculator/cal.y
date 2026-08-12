%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define YYSTYPE double

void yyerror(const char *s);
int yylex(void);
%}

%token NUM
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
    | expn '\n' { printf("Answer: %g\n\n", $1); }
    ;

expn:
    expn '+' expn { $$ = $1 + $3; }
    | expn '-' expn { $$ = $1 - $3; }
    | expn '*' expn { $$ = $1 * $3; }
    | expn '/' expn { 
        if ($3 == 0) {
            printf("Error: Division by zero\n");
            $$ = 0;
        } else {
            $$ = $1 / $3; 
        }
    }
    | '-' expn %prec UMINUS { $$ = -$2; }
    | '(' expn ')' { $$ = $2; }
    | NUM { $$ = $1; }
    ;

%%

void yyerror(const char *s) {
    printf("Syntax Error in Expression\n\n");
}

int main() {
    printf("Enter calculation expression(s):\n");
    yyparse();
    return 0;
}
