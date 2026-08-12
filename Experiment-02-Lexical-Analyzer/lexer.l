%{
#include <stdio.h>
#include <stdlib.h>
%}

%option noyywrap

%%

"#include"[ \t]*"<"[^>\n]+">"   { printf("<HEADER_FILE, %s>\n", yytext); }
"#define"[ \t]+[a-zA-Z_][a-zA-Z0-9_]*  { printf("<PREPROCESSOR, %s>\n", yytext); }

"int"|"float"|"char"|"double"|"void"|"return"|"if"|"else"|"while"|"for"|"do"|"switch"|"case"|"break"|"continue"|"struct"  { 
    printf("<KEYWORD, %s>\n", yytext); 
}

[a-zA-Z_][a-zA-Z0-9_]*        { printf("<IDENTIFIER, %s>\n", yytext); }

[0-9]+(\.[0-9]+)?             { printf("<NUMBER, %s>\n", yytext); }

\"([^\\\"]|\\.)*\"            { printf("<STRING_LITERAL, %s>\n", yytext); }

"//".*                        { printf("<COMMENT, %s>\n", yytext); }
"/*"([^*]|\*+[^/*])*\*+"/"    { printf("<COMMENT, %s>\n", yytext); }

"+"|"-"|"*"|"/"|"%"|"="|"=="|"!="|"<"|">"|"<="|">="|"&&"|"||"  { printf("<OPERATOR, %s>\n", yytext); }

"{"|"}"|"("|")"|"["|"]"|";"|","  { printf("<DELIMITER, %s>\n", yytext); }

[ \t\n]+                      { /* ignore whitespaces */ }

.                             { printf("<UNKNOWN_TOKEN, %s>\n", yytext); }

%%

int main(int argc, char** argv) {
    if (argc > 1) {
        FILE* fp = fopen(argv[1], "r");
        if (!fp) {
            printf("Could not open file: %s\n", argv[1]);
            return 1;
        }
        yyin = fp;
    }
    printf("========== LEXICAL ANALYZER TOKENS ==========\n");
    yylex();
    printf("==============================================\n");
    return 0;
}
