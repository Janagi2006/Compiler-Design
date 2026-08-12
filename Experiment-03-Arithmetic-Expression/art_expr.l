%{
#include <stdio.h>
#include "art_expr.tab.h"
%}

%option noyywrap

%%

[a-zA-Z_][a-zA-Z0-9_]*  { return ID; }
[0-9]+                  { return DIG; }
[ \t]+                  { /* ignore whitespace */ }
\n                      { return '\n'; }
.                       { return yytext[0]; }

%%
