%{
#include <stdio.h>
#include "valvar.tab.h"
%}

%option noyywrap

%%

[a-zA-Z]  { return LET; }
[0-9]     { return DIG; }
[ \t]+    { /* ignore spaces */ }
\n        { return '\n'; }
.         { return yytext[0]; }

%%
