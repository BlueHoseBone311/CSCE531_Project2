# Title: Makefile - simple expression eval
# Christian Merchant
# 03-06-15
#

CC = gcc
CFLAGS = -g
LIBS = -lfl
YACC = bison
LEX = flex
OBJECTS = eval.o tree.o parse.o main.o lex.yy.o

see: $(OBJECTS)
	$(CC) $(CFLAGS) $(OBJECTS) $(LIBS) -o see

eval.o: eval.c tree.h eval.h defs.h  
	$(CC) $(CFLAGS) eval.c 

tree.o: tree.c tree.h defs.h
	$(CC) $(CFLAGS) tree.c

main.o:	main.c eval.h
	$(CC) $(CFLAGS) main.c 

lex.yy.o: lex.yy.c
	$(CC) $(CFLAGS) lex.yy.c

parse.o: parse.c
	$(CC) $(CFLAGS) parse.c	

y.tab.h parse.c: parse.y tree.h eval.h defs.h
	$(YACC) -y -d -t -v parse.y
	mv y.tab.c parse.c

lex.yy.c: scan.l tree.h eval.h defs.h y.tab.h 
	$(LEX) scan.l	

clean:
	-rm *.o lex.yy.c parse.c y.tab.h y.output see
