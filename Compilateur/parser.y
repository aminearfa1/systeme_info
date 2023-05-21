%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


void yyerror(const char *);
extern int yylex();

%}
%union {
    char* strval;
    int numval;
}

%define parse.error verbose
// Récupération des tokens
%token tMAIN
%token tOBRACKET tCBRACKET
%token tOBRACE tCBRACE
%token tOCROCH tCCROCH
%token tINT
%token tCONST
%token tPV tCOMA
%token tMUL tDIV tADD tSUB tEQ
%token <numval>  tNB tNBEXP
%token <strval> tID
%token tSTR
%token tPRINT tGET tSTOP
%token tIF tELSE
%token tWHILE
%token tRETURN
%token tLT tGT tEQCOND
%token tAND tOR
%token tADDR

%left tLT tGT
%left tEQCOND
%left tAND tOR
%left tNOT
%left tADD tSUB
%left tMUL tDIV

%right tINT tMAIN







%%
Program : Functions  { printf("début du programme\n"); };

Main: tINT tMAIN tOBRACE Args tCBRACE Body  { printf("Main principal\n"); };

Functions : Main
          | Fonction Functions
          ;

Fonction : Type tID tOBRACE Args tCBRACE Body
         { printf("Function declaration: %s\n", $2); }
         ;

Get : tGET tOBRACE tCBRACE { printf("Get statement\n"); };

Print : tPRINT tOBRACE E tCBRACE 

Print : tPRINT tOBRACE tSTR tCBRACE 

Stop : tSTOP tOBRACE tNB tCBRACE { printf("Stop statement\n"); };

Return : tRETURN E tPV { printf("Return statement\n"); };


Args : Arg ArgSuite
     |
     ;
Arg : Type tID
     |Type tID tOCROCH tCCROCH
     ;

ArgSuite : tCOMA Arg ArgSuite
         |
         ;

Body : tOBRACKET Instructions tCBRACKET
     { printf("Function body\n"); }
     ;

Instructions : Instruction Instructions
             |
             ;

Instruction : Aff           { printf("Assignment\n"); }
            | Decl            { printf("Variable declaration\n"); }
            | Invocation tPV 
            | If           
            | While            { printf("While loop\n"); }
            | Return          
            | Stop tPV            { printf("Stop statement\n"); }
            | Print tPV            { printf("Print statement\n"); }
            | Get tPV            { printf("Get statement\n"); }
            ;

Invocation : tID tOBRACE Params tCBRACE
           { printf("Function invocation: %s\n", $1); }
           ;

Params : Param SuiteParams
       |
       ;

Param : E
      ;

SuiteParams : tCOMA Param SuiteParams
            |
            ;

If : tIF tOBRACE E tCBRACE Body Else
   { printf("If statement\n"); }
   ;

Else : tELSE If
     { printf("Else if statement\n"); }
     | tELSE Body
     { printf("Else statement\n"); }
     |
     ;

While : tWHILE tOBRACE E tCBRACE Body
      { printf("While loop\n"); }
      ;

Aff : tID tEQ E tPV
    { printf("Symbol assignment\n"); }
    ;



E : tNB 	  { printf("Number\n"); }
   | tNBEXP   { printf("Exponential number\n"); }
   | E tMUL E { printf("Multiplication\n"); }
   | E tDIV E { printf("Division\n"); }
   | E tSUB E { printf("Subtraction\n"); }
   | E tADD E { printf("Addition\n"); }
   | Invocation	
   | tOBRACE E tCBRACE	{ printf("Parenthesized expression\n"); }
   | tSUB E	{ printf("Unary minus\n"); }
   | E tEQCOND E	{ printf("Conditional expression\n"); }
   | E tGT E	{ printf("Greater than\n"); }
   | E tLT E	{ printf("Less than\n"); }
   | tNOT E	{ printf("Logical negation\n"); }
   | E tAND E	{ printf("Logical AND\n"); }
   | E tOR E	{ printf("Logical OR\n"); }
   | tMUL E	{ printf("Dereference\n"); }
   | tID	{ printf("Identifier\n"); }
   | tID tOCROCH E tCCROCH	{ printf("Array indexing\n"); }
;

Type : tINT
| Type tMUL
| tCONST Type
;

Decl : Type UneDecl FinDecl 
;

UneDecl : tID
| tID tEQ E 
| tID tOCROCH tNB tCCROCH { printf("Array declaration\n"); }
| tID tOCROCH tNB tCCROCH tEQ tOBRACKET InitTab tCBRACKET { printf("Array declaration with initialization\n"); }
;

FinDecl : tPV
| tCOMA UneDecl FinDecl
|
;

InitTab : E SuiteInitTab
;

SuiteInitTab : tCOMA E SuiteInitTab
|
;
%%

void yyerror(const char *msg) {
fprintf(stderr, "Erreur de syntaxe : %s\n", msg);
}
