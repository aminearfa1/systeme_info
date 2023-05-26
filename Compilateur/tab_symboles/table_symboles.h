#include <stdint.h>

enum type_t {UNKNOWN, INT};
extern int taille_types[];
extern int profondeur;

struct symbole_t {
	char nom[30];
	uintptr_t adresse;
	enum type_t type;
	int initialized;
    int profondeur;
};

void print_symbole(struct symbole_t symbole);


void init(void);
int push(char * nom, int isInit, enum type_t type);
struct symbole_t pop();
// renvoi 0 si nom n'existe pas, 2 si nom existe sans etre initialisée, 1 sinon
char status(char * nom);
void print();
int get_last_addr();
struct symbole_t * get_variable(char * nom);
int allocate_mem_temp_var(enum type_t type);
void reset_temp_vars();
void reset_pronf();
