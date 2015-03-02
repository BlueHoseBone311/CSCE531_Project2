# Title: Makefile - simple expression eval
# Christian Merchant
# 03-04-15
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

tree.o: tree.c
	$(CC) $(CFLAGS) tree.c

y.tab.h parse.c: parse.y tree.h
	$(YACC) -y -d -t -v parse.y
	mv y.tab.c parse.c

lex.yy.c: scan.l y.tab.h tree.h
	$(LEX) scan.l 

clean:
	-rm *.o lex.yy.c parse.c y.output see
