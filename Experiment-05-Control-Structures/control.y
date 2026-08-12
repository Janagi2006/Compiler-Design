%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);
%}

%token IF ELSE FOR WHILE SWITCH CASE DEFAULT BREAK
%token ID NUM
%token LBRACE RBRACE LPAREN RPAREN COLON SEMICOLON
%token EQ LE GE LT GT ASSIGN

%%

program:
    stmt_list
    ;

stmt_list:
    stmt_list stmt
    | stmt
    ;

stmt:
    if_stmt
    | while_stmt
    | for_stmt
    | switch_stmt
    | expr_stmt
    | block_stmt
    ;

block_stmt:
    LBRACE stmt_list RBRACE
    | LBRACE RBRACE
    ;

expr_stmt:
    ID ASSIGN NUM SEMICOLON
    | ID ASSIGN ID SEMICOLON
    | BREAK SEMICOLON
    ;

if_stmt:
    IF LPAREN cond RPAREN stmt
    | IF LPAREN cond RPAREN stmt ELSE stmt
    ;

while_stmt:
    WHILE LPAREN cond RPAREN stmt
    ;

for_stmt:
    FOR LPAREN ID ASSIGN NUM SEMICOLON cond SEMICOLON ID ASSIGN ID RPAREN stmt
    ;

switch_stmt:
    SWITCH LPAREN ID RPAREN LBRACE case_list RBRACE
    ;

case_list:
    case_list CASE NUM COLON stmt_list
    | case_list DEFAULT COLON stmt_list
    | CASE NUM COLON stmt_list
    | DEFAULT COLON stmt_list
    ;

cond:
    ID relop NUM
    | ID relop ID
    ;

relop:
    EQ | LE | GE | LT | GT
    ;

%%

void yyerror(const char *s) {
    printf("Invalid control structure syntax.\n");
}

int main() {
    printf("Enter C control structure syntax:\n");
    if (yyparse() == 0) {
        printf("Valid control structure syntax.\n");
    }
    return 0;
}
