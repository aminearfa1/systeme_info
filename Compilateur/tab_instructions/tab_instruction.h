#ifndef TAB_INST_H
#define TAB_INST_H

#include <stdlib.h>
#include <string.h>
#include <stdio.h>

// Liste de codes des instructions
enum opcode_t {
	ADD, MUL, SOU, DIV, COP, AFC, AFCA, JMP, JMF, INF, SUP, EQU, PRI, READ
};

// Ajoute une opération dans la table (à la fin)
void add_operation(enum opcode_t opcode, int arg1, int arg2, int arg3);

// Renvoie le prochain slot disponible
int get_current_index();

// Permet de patcher les Jump (pas de Van Halen)
void patch(int index, int arg);

// Ecrit la table des instructions dans un fichier ASM
void create_asm();

// Crée la ligne assembleur en 1er dans le fichier pour sauter au main
void create_jump_to_main(int line);

#endif

