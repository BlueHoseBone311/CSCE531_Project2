#
#	makefile for the Simple Expression Evaluator
#
#

CC = gcc
CFLAGS = -g
LIBS = -lfl
YACC = bison
LEX = flex
SOURCE = parse.y main.c
OBJECTS = parse.o main.o lex.yy.o

see: $(OBJECTS)
	$(CC) $(CFLAGS) $(OBJECTS) $(LIBS) -o see

main.o: main.c
	$(CC) $(CFLAGS)	main.c

parse.o: parse.c
	$(CC) $(CFLAGS) parse.c

lex.yy.o: lex.yy.c
	$(CC) $(CFLAGS) lex.yy.c 

y.tab.h parse.c: parse.y defs.h
	$(YACC) -y -d -t -v parse.y
	mv y.tab.c parse.c

lex.yy.c: scan.l y.tab.h defs.h
	$(LEX) scan.l 

clean:
	-rm *.o lex.yy.c parse.c y.output see
