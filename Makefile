# Title: Makefile - simple expression eval
# Christian Merchant
# 03-06-15

CC = gcc

CFLAGS = -g

LIBS = -lfl

YACC = bison

LEX = flex

SOURCE = parse.y main.c lex.yy.c eval.c tree.c

OBJECTS = parse.o main.o lex.yy.o eval.o tree.o 

see: $(OBJECTS)
	$(CC) $(CFLAGS) $(OBJECTS) $(LIBS) -o see

y.tab.h parse.c: parse.y
	$(YACC) -y -d -t -v parse.y
	mv y.tab.c parse.c

lex.yy.c: scan.l
	$(LEX) scan.l


clean:
	-rm *.o lex.yy.c parse.c y.tab.h y.output see