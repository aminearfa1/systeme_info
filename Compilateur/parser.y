%{
#include "tab_symboles/table_symboles.h"
#include "tab_instructions/tab_instruction.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *msg);
struct type_t type_courant;

extern int yylex();

// Tableau pour le management des patchs des JMP
int instructions_ligne_to_patch[10][20];
int nbs_instructions_to_patch[10];
%}

%union {
	int nombre;
    char id[30];
    char str[300];
}



%define parse.error verbose

// Récupération des tokens
%token tMAIN
%token tOBRACKET tCBRACKET
%token<nombre> tOBRACE tCBRACE
%token tOCROCH tCCROCH
%token tINT
%token tCONST
%token tPV tCOMA
%token tMUL tDIV tADD tSUB tEQ
%token<nombre> tNB tNBEXP
%token<id> tID
%token tSTR
%token tPRINT tGET tSTOP
%token<nombre> tIF tELSE
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
%type<nombre> E Invocation


%%
Program : Functions  { printf("début du programme\n");  print(); create_asm();};

Main: tINT tMAIN tOBRACE Args tCBRACE Body  { printf("Main principal\n"); };

Functions : Main
          | Fonction Functions
          ;

Fonction : Type tID tOBRACE Args tCBRACE Body
         { printf("Function declaration: %s\n", $2); }
         ;


Print : tPRINT tOBRACE E tCBRACE  {add_operation(PRI,$3,0,0);                                      // On ajoute l'instruction PRI

                                  };


// Stop, une fonction particulière
Stop : tSTOP tOBRACE tNB tCBRACE  {};

// Return, etape clé d'une fonction
Return : tRETURN E tPV          {};

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
            ;

Invocation : tID tOBRACE Params tCBRACE
           { printf("Function invocation: %s\n", $1); }
           ;
Params: {};
Params : Param SuiteParams
       ;

Param : E
      ;

SuiteParams : tCOMA Param SuiteParams {};
SuiteParams :
            ;
/*************************************/

// Un if : le token, une expression entre parenthèses suivie d'un body et d'un else
If : tIF tOBRACE E tCBRACE {
	printf("If statement\n");
    add_operation(JMF, $3, 0, 0);  
    $1 = get_current_index() - 1;  
}

Body {
    int current = get_current_index();  
    patch($1, current + 1);  
    add_operation(JMP, 0, 0, 0);  
    instructions_ligne_to_patch[get_prof()][nbs_instructions_to_patch[get_prof()]] = current; 
    nbs_instructions_to_patch[get_prof()]++;

}
Else;

Else : tELSE Body {
	printf("Else statement\n");
    int current = get_current_index();
    for (int i = 0; i < nbs_instructions_to_patch[get_prof()]; i++) {
        patch(instructions_ligne_to_patch[get_prof()][i], current);  
    }
    nbs_instructions_to_patch[get_prof()] = 0;
};

Else :  {
    int current = get_current_index();
    for (int i = 0; i < nbs_instructions_to_patch[get_prof()]; i++) {
        patch(instructions_ligne_to_patch[get_prof()][i], current); 
    }
    nbs_instructions_to_patch[get_prof()] = 0;
};

/*************************************/

While : tWHILE tOBRACE E tCBRACE Body
      { printf("While loop\n"); }
      ;
/*************************************/


Aff : tID tEQ E tPV { printf("%s prend une valeur\n", $1); struct symbole_t * symbole  = get_variable($1); symbole->initialized = 1; add_operation(COP, symbole->adresse, $3,0);} ; //besoin de get_address

E : tNB                                  {
  int addr = push("TEMP_V", 1, integer );
  add_operation(AFC, addr,$1,0);
  $$ = addr;
};

E : tNBEXP                               {
  int addr = push("TEMP_V", 1, integer ); 
  add_operation(AFC, addr,$1,0); 
  $$ = addr;
};

E : E tMUL E                             {
  add_operation(MUL,$1,$1,$3);
  $$ = $1;
  pop();
};

E : E tDIV E                             {
  add_operation(DIV, $1,$1,$3); 
  $$ = $1; 
  pop();
};


E : E tSUB E                             {
  add_operation(SOU,$1,$1,$3); 
  $$ = $1; 
  pop();
};

E : E tADD E                             {
  add_operation(ADD,$1,$1,$3); 
  $$ = $1; 
  pop();
};

E : Invocation                           {
  $$ = $1;
};

E : tOBRACE E tCBRACE                    {
  $$ = $2;
};

E : tSUB E                               {
  int addr = push("TEMP_V", 1, integer );
  add_operation(AFC, addr,0,0);
  add_operation(SOU, $2, addr, $2);
  $$ = $2;
  pop();
};

E : E tEQCOND E                          {
  add_operation(EQU,$1,$1,$3);
  $$ = $1;
  pop();
};

E : E tGT E                              {
  add_operation(SUP,$1,$1,$3); 
  $$ = $1; 
  pop();
};

E : E tLT E                              {
  add_operation(INF,$1,$1,$3); 
  $$ = $1; 
  pop();
};

E : tNOT E                               {
  int addr = push("TEMP_V", 1, integer );
  add_operation(AFC, addr,0,0);
  add_operation(EQU, $2, addr, $2);
  $$ = $2;
  pop();
};

E : E tAND E                             {
  add_operation(MUL,$1,$1,$3); 
  $$ = $1; 
  pop();
};

E : E tOR E                              {
  add_operation(ADD,$1,$1,$3); 
  $$ = $1; 
  pop();
};

E : tMUL E                               {
  add_operation(READ, $2, $2, 0);
  $$=$2;
};


E : tID                                  {struct symbole_t * symbole  = get_variable($1);         
                                          struct type_t type = symbole->type;                      
                                          type.nb_blocs = 1; 
                                          int addr = push("0_TEMPORARY", 1, type);                
                                          if (symbole->type.isTab == 1) {
                                            add_operation(AFCA, addr,symbole->adresse,0);         
                                          } else {
                                            add_operation(COP, addr,symbole->adresse,0);           
                                          } 
                                          $$ = addr;
                                  		  pop(); 

                                         };

Type : tINT                              {type_courant.base = INT; 
                                          type_courant.pointeur_level = 0;
																					type_courant.isConst = 0;
                                         };

Type :  tCONST Type;
;

Decl : Type UneDecl FinDecl 
;

UneDecl : tID                            {type_courant.isTab = 0;                                  // On est pas un tableau
                                          type_courant.nb_blocs = 1;                              // On fixe le nombre de blocs
                                          push($1, 0, type_courant);
                                         };
                                         
// Une déclaration d'une simple variable avec initialisation
UneDecl : tID tEQ E                      {pop();                                                  
                                          type_courant.isTab = 0;                                 
                                          type_courant.nb_blocs = 1;                                                        
                                          push($1,1, type_courant);                     
                                         }; 
UneDecl : tID tOCROCH tNB tCCROCH { printf("Array declaration\n"); };
UneDecl : tID tOCROCH tNB tCCROCH tEQ tOBRACKET InitTab tCBRACKET { printf("Array declaration with initialization\n"); }
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

int main() {
    init();
    yyparse();
    return 0;
}

