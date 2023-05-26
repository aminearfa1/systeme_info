#include "tab_instruction.h"

int main() {
	// Ajout des opérations dans la table
	add_operation(ADD, 1, 2, 3);
	add_operation(MUL, 4, 5, 6);
	add_operation(AFC, 7, 8, 0);
	
	// Patch du JMP
	patch(0, 10);
	
	// Création de la ligne JMP vers le main
	create_jump_to_main(20);
	
	// Génération du code ASM dans un fichier
	create_asm();
	
	return 0;
}

