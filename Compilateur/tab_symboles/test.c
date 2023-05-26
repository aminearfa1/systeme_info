#include <stdio.h>
#include "table_symboles.h"

int main() {
    // Initialisation de la table des symboles
    init();

    // Ajout de symboles
    push("var1", 1, INT);
    push("var2", 0, INT);
    push("var3", 1, INT);

    // Affichage de la table des symboles
    printf("Table des symboles après l'ajout initial :\n");
    print();


    // Récupération d'un symbole
    struct symbole_t* symbole = get_variable("var2");
    if (symbole != NULL) {
        printf("Adresse de var2 : %lu\n", (uintptr_t)symbole->adresse);
    } else {
        printf("var2 n'a pas été trouvé dans la table des symboles.\n");
    }

    // Suppression d'un symbole
    struct symbole_t pop_symbole = pop();
    printf("Symbole supprimé :\n");
    print_symbole(pop_symbole);

    // Affichage de la table des symboles après suppression
    printf("Table des symboles après la suppression d'un symbole :\n");
    print();

    return 0;
}

