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

y.tab.h parse.c: parse.y 
	$(YACC) -y -d -t -v parse.y
	mv y.tab.c parse.c

lex.yy.c: scan.l y.tab.h 
	$(LEX) scan.l 

clean:
	-rm *.o lex.yy.c parse.c y.tab.h y.output see
