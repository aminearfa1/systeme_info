#include "tab_instruction.h"
#define MAXTAILLE 1024

// Structure représentant une opération
struct operation_t {
	enum opcode_t opcode;
	int arg1;
	int arg2;
	int arg3;
};

// Index dans le tableau des instructions
int current_index = 1;
// Tableau des instructions (programme en assembleur)
struct operation_t tab_op[MAXTAILLE];

// Insertion d'une opération dans le tableau
void add_operation(enum opcode_t opcode, int arg1, int arg2, int arg3) {
	if (current_index == MAXTAILLE) {
		printf("Taillemax tableau operations atteinte\n");
	} else {
		struct operation_t new_op = {opcode, arg1, arg2, arg3};
		tab_op[current_index] = new_op;
		current_index++;
	}
}

// Les fonctions étant compilées en premiers, la première instruction du programme doit être un JMP vers le main
void create_jump_to_main(int line) {
    struct operation_t new_op = {JMP, line, 0, 0};
    tab_op[0] = new_op;
}

// Fonction traduisant une opération en assembleur
char * get_asm_line_from_op(struct operation_t op) {
	char * buffer = malloc(sizeof(char) * 200);
	switch (op.opcode) {
		case (ADD):
			sprintf(buffer, "ADD %d %d %d\n", op.arg1, op.arg2, op.arg3);
			break;
		case (MUL):
			sprintf(buffer, "MUL %d %d %d\n", op.arg1, op.arg2, op.arg3);
			break;
		case (SOU):
			sprintf(buffer, "SOU %d %d %d\n", op.arg1, op.arg2, op.arg3);
			break;
		case (DIV):
			sprintf(buffer, "DIV %d %d %d\n", op.arg1, op.arg2, op.arg3);
			break;
		case (COP):
			sprintf(buffer, "COP %d %d\n", op.arg1, op.arg2);
			break;
		case (AFC):
			sprintf(buffer, "AFC %d %d\n", op.arg1, op.arg2);
			break;
		case (AFCA):
			sprintf(buffer, "AFCA %d %d\n", op.arg1, op.arg2);
			break;
		case (JMP):
			sprintf(buffer, "JMP %d\n", op.arg1);
			break;
		case (JMF):
			sprintf(buffer, "JMF %d %d\n", op.arg1, op.arg2);
			break;
		case (INF):
			sprintf(buffer, "INF %d %d %d\n", op.arg1, op.arg2, op.arg3);
			break;
		case (SUP):
			sprintf(buffer, "SUP %d %d %d\n", op.arg1, op.arg2, op.arg3);
			break;
		case (EQU):
			sprintf(buffer, "EQU %d %d %d\n", op.arg1, op.arg2, op.arg3);
			break;
		case (PRI):
			sprintf(buffer, "PRI %d\n", op.arg1);
			break;
		case (READ):
			sprintf(buffer,"READ %d %d\n",op.arg1, op.arg2);
			break;	
	}
	return buffer;
}

// Génère le code asm dans un fichier
void create_asm() {
    char *filename = "/home/arfa/Bureau/systeme_info/Compilateur/Interpreteur/asm.txt";
    FILE *output = fopen(filename, "w");
    if (output == NULL) {
        printf("Impossible d'ouvrir le fichier %s\n", filename);
        return;
    }
    
    for (int i = 0; i < current_index; i++) {
        char *line = get_asm_line_from_op(tab_op[i]);
        fputs(line, output);
        free(line);
    }
    
    fclose(output);
}


// Renvoie l'index courant dans le tableau
int get_current_index() {
	return current_index;
}

// Permet de modifier une instruction a posteriori (pour les JMP)
void patch(int index, int arg) {
	if (tab_op[index].opcode == JMP) {
		tab_op[index].arg1 = arg;
	} else if (tab_op[index].opcode == JMF) {
		tab_op[index].arg2 = arg;
	}
}


