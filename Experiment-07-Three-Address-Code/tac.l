%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char str[32];
} YYSTYPE_STRUCT;

#define YYSTYPE YYSTYPE_STRUCT

#include "tac.tab.h"
%}

%option noyywrap

%%

[a-zA-Z_][a-zA-Z0-9_]* { 
    strcpy(yylval.str, yytext); 
    return ID; 
} 

[0-9]+ { 
    strcpy(yylval.str, yytext); 
    return NUM; 
} 

[\t\n ]+ { /* skip spaces */ }
. { return yytext[0]; }

%%
