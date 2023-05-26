CC = gcc
CFLAGS = -Wall


compilateur: lex.yy.c parser.tab.c
	$(CC) $(CFLAGS) -o compilateur lex.yy.c parser.tab.c

lex.yy.c: lex.l
	flex lex.l

parser.tab.c: parser.y
	bison -d parser.y

test_tab_symboles: tab_symboles/table_symboles.c tab_symboles/test.c
	$(CC) $(CFLAGS) -o test_tab_symboles tab_symboles/table_symboles.c tab_symboles/test.c && ./test_tab_symboles

clean:
	rm -f lex.yy.c parser.tab.c parser.tab.h compilateur table_symboles.o test.o test_tab_symboles

