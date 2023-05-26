#include "table_symboles.h"
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#define MAXADDR 1024*5

int last_addr = 0;
int temp_addr = MAXADDR;
int taille_types[] = {-1, 4};
int profondeur = 0;

struct element_t {
	struct symbole_t symbole;
	struct element_t * suivant;
};

struct pile_t {
	int taille;
	struct element_t * first;
};
struct pile_t * pile;

// Convertit le type en une chaîne de caractères
char * type_to_string(enum type_t type) {
	if (type == INT) {
		return "int";
	} else {
		return "unknown";	
	}
}

// Affiche un symbole
void print_symbole(struct symbole_t symbole) {
    if (symbole.initialized) {
		printf("\t\t{nom:%s, adresse:%ld, type:%s, initialized:OUI, profondeur : %d}\n", symbole.nom, symbole.adresse, type_to_string(symbole.type), symbole.profondeur);
	} else {
		printf("\t\t{nom:%s, adresse:%ld, type:%s, initialized:NON, profondeur : %d}\n", symbole.nom, symbole.adresse, type_to_string(symbole.type),symbole.profondeur);
	}
}

// Initialise la table des symboles
void init(void) {
    pile = malloc(sizeof(struct pile_t));
	pile->first = NULL;
	pile->taille = 0;
}

// Ajoute un symbole à la table
int push(char * nom, int isInit, enum type_t type) {
	struct element_t * aux = malloc(sizeof(struct element_t));
	struct symbole_t symbole = {"", last_addr, type, isInit, profondeur}; 
	strcpy(symbole.nom, nom);
	aux->symbole = symbole;
	aux->suivant = pile->first;
	pile->first = aux;
	pile->taille++;
	int addr_var = last_addr;
	last_addr += taille_types[type]; 
	return addr_var;
}

// Supprime et renvoie le dernier symbole de la table
struct symbole_t pop() {
	struct symbole_t retour = {"", 0, UNKNOWN, 0, 0};
	struct element_t * aux;
	if (pile->taille > 0) {
		aux = pile->first;
		pile->first = pile->first->suivant;
		retour = aux->symbole;
		free(aux);
		pile->taille--;
		last_addr -= taille_types[retour.type]; 
	}
	return retour;
}
		
// Récupère un symbole de la table en fonction de son nom
struct symbole_t * get_variable(char * nom) {
	struct symbole_t * retour = NULL;
	struct element_t * aux = pile->first;
	int i;
	for (i = 0; i < pile->taille; i++) {
		if (!strcmp(nom, aux->symbole.nom)) {
			retour = &aux->symbole;
			break;
		} else {
			aux = aux->suivant;
		}
	}
	return retour;
}

// Affiche la table des symboles
void print() {
	printf("Affichage de la Table des Symboles\n");
	printf("------------------------------------------------|\n");
	printf("|   Nom   |   Adresse  |   Type  |  Profondeur  |\n");
	printf("------------------------------------------------|\n");
	struct element_t* aux = pile->first;
	int i;
	for (i = 0; i < pile->taille; i++) {
		printf("|%9s|%12ld|%10s|", aux->symbole.nom, aux->symbole.adresse, type_to_string(aux->symbole.type));
		printf("%12d|\n", aux->symbole.profondeur);
		aux = aux->suivant;
	}
	printf("-------------------------------------------------|\n");
}

// Récupère la dernière adresse allouée dans la table des symboles
int get_last_addr() {
	return last_addr;
}

// Alloue de la mémoire pour une variable temporaire de type spécifié
int allocate_mem_temp_var(enum type_t type) {
	temp_addr -= taille_types[type];
	return temp_addr;
}

// Réinitialise les variables temporaires
void reset_temp_vars() {
	temp_addr = MAXADDR;
}

// Réinitialise la profondeur des symboles de la table en les retirant jusqu'à atteindre une profondeur inférieure
void reset_pronf() {
	while (pile->first->symbole.profondeur == profondeur) {
		pop();
	}
}

