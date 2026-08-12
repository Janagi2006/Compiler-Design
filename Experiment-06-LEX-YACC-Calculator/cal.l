%{
#include <stdio.h>
#include <stdlib.h>
#define YYSTYPE double
#include "cal.tab.h"
%}

%option noyywrap

DIGIT [0-9]+(\.[0-9]+)?

%%

{DIGIT} {
    yylval = atof(yytext);
    return NUM;
}

[ \t]+  { /* ignore space/tabs */ }
\n      { return '\n'; }
.       { return yytext[0]; }

%%
