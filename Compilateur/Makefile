CC = gcc
CFLAGS = -Wall


compilateur: lex.yy.c parser.tab.c
	$(CC) $(CFLAGS) -o compilateur lex.yy.c parser.tab.c tab_instructions/tab_instruction.c tab_symboles/table_symboles.c 

lex.yy.c: lex.l
	flex lex.l

parser.tab.c: parser.y
	bison -d parser.y
	
test_tab_instructions: tab_instructions/tab_instruction.c tab_instructions/test.c
	$(CC) $(CFLAGS) -o test_tab_instructions tab_instructions/tab_instruction.c tab_instructions/test.c && ./test_tab_instructions && cat asm.txt

test_tab_symboles: tab_symboles/table_symboles.c tab_symboles/test.c
	$(CC) $(CFLAGS) -o test_tab_symboles tab_symboles/table_symboles.c tab_symboles/test.c && ./test_tab_symboles


test_arith0:
	./compilateur < tests/arith0.txt 
	 python Interpreteur/cross_assembler.py 
	python Interpreteur/interpreter.py

test_arith1:
	./compilateur < tests/arith1.txt 
	 python Interpreteur/cross_assembler.py 
	python Interpreteur/interpreter.py

test_if:
	./compilateur < tests/if.txt 
	 python Interpreteur/cross_assembler.py 
	python Interpreteur/interpreter.py

test_else:
	./compilateur < tests/else.txt 
	 python Interpreteur/cross_assembler.py 
	python Interpreteur/interpreter.py


clean:
	rm -f lex.yy.c parser.tab.c parser.tab.h  table_symboles.o test.o test_tab_symboles test_tab_instructions output.txt asm.txt

