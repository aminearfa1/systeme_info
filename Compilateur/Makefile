LEX=flex
YACC=bison
CC=gcc
CFLAGS=-Wall

.PHONY: all clean check

all: parser

parser: lex.yy.c parser.tab.c main.c
	$(CC) $(CFLAGS) $^ -o $@

lex.yy.c: lex.l
	$(LEX) $<

parser.tab.c: parser.y
	$(YACC) -d $<

check: parser test1.txt
	./parser < test1.txt

clean:
	rm -f parser lex.yy.c parser.tab.c parser.tab.h

