%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "parser.tab.h"

%}

%option noyywrap
%option noinput
%option nounput

%{
// Define token types

%}

%%

"int"           { return tINT;}
"const"           { return tCONST;}
"main"          { return tMAIN;}

"if"            { return tIF;}
"else"          { return tELSE;}
"while"         { return tWHILE; }

"print"         { return tPRINT; }
"get"           { return tGET; }
"stop"          { return tSTOP; }

"return"        { return tRETURN; }

"=="            { return tEQCOND;};
"<"             { return tLT; }
">"             { return tGT; }

"="             { return tEQ; }
"&&"            { return tAND; }
"||"            { return tOR; }
"!"             { return tNOT; }
"&"             { return tADDR; }

"+"             { return tADD; }
"-"             { return tSUB; }
"*"             { return tMUL; }
"/"             { return tDIV; }

"{"             { return tOBRACKET; }
"}"             { return tCBRACKET; }
"("             { return tOBRACE; }
")"             { return tCBRACE; }
"["             { return tOCROCH; }
"]"             { return tCCROCH; }
";"             { return tPV ; }
","             { return tCOMA; }

"//".*          { /* ignore comments */ }
"/*"([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*\*+"/" { /* ignorer le commentaire */ }

[0-9]+          { yylval.numval = atoi(yytext); printf("tNB: '%d[%#x]'\n", yylval.numval, yylval.numval);return tNB;}

0[xX][0-9a-fA-F]+    { yylval.numval = strtol(yytext, NULL, 16); printf("tNB: '%d[0x%x]'\n", yylval.numval, yylval.numval);return tNB;}

[a-zA-Z][a-zA-Z0-9]* { yylval.strval = strdup(yytext); printf("tID: '%s'\n", yylval.strval); return tID;}
                
[ \t\n\r]       { /* ignore whitespace */ }


%%
