/* @Title   parse.y - Bison File
 * @author  Christian Merchant
 * @class   CSCE531
 * @Project Bison Project
 * @date    03-04-15
 */

%{
#include "defs.h"
#include <ctype.h>
#define YYDEBUG 1
int  get_val(int);
void set_val(int, int);
%}

%union 
{
    long y_int;
    TN y_tree; 
}
%type <y_tree> expr term factor
%token <y_int> CONST VAR

%%

session
    : { print_welcome(); }
      eval
    ;

eval
    : eval line
    | /* empty */
    ;

line
    : assign '\n'		    { printf("%d\n", $1); }
    ;

assign
    : VAR '=' expr		    { set_val($1, $3);  $$ = $3; }
    | expr
    ;

expr
    : expr '+' term		    {$$ = make_binop_node($1, $3,BIN_PLUS); }
    | expr '-' term		    {$$ = make_binop_node($1, $3, BIN_MINUS); }
    |'-' expr               {$$ = make_unop_node($2,UN_MINUS);}
    |'+' expr               {$$ = make_unop_node($2,UN_PLUS);}
    |'++' expr              {$$ = make_unop_node($2,INC);}
    |'--' expr              {$$ = make_unop_node($2,DEC);}
    | term
    ;

term
    : term '*' factor		{$$ = make_binop_node($1, $3, MULT);}
    | term '/' factor		{$$ = make_binop_node($1, $3, DIV);}
    | term '%' factor		{$$ = make_binop_node($1, $3, MOD);}
    |'-' term               {$$ = make_unop_node($2,UN_MINUS);}
    |'+' term               {$$ = make_unop_node($2,UN_PLUS);}
    |'++' term              {$$ = make_unop_node($2,INC);}
    |'--' term              {$$ = make_unop_node($2,DEC);}
    | factor
    ;

factor
    : '(' expr ')'	 	    {$$ = $2;}
    | CONST                 {$$ = make_const_node($1);}
    | VAR			        {$$ = make_var_node(get_val($1));}
    ;

%%

yyerror(char *s)
{
    fprintf(stderr, "%s\n", s);
}

print_welcome()
{
    printf("Welcome to the Simple Expression Evaluator.\n");
    printf("Enter one expression per line, end with ^D\n\n");
}

static long val_tab[26];

long get_val(int v)
{
    return val_tab[v - 'A'];
}

void set_val(int v, long val)
{
    val_tab[v - 'A'] = val;
}
