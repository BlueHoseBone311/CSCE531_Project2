/* @Title   parse.y - Bison File
 * @author  Christian Merchant
 * @class   CSCE531
 * @Project Bison Project
 * @date    03-06-15
 */


%{
#include <ctype.h>
#include <stdlib.h>
#include <stdio.h>
#include "defs.h"
#include "eval.h"
#include "tree.h"
#define YYDEBUG 1

int check_range(long value); 
int check_error(TN node);
void set_val(long, long);

long expr_count =1; 
int cache_flag = FALSE;
static long value = 0; 
%}

%union 
{
    long y_int; 
    TN y_tree; 
}

%type <y_tree> expr term factor 
%type <y_int> assign
%token <y_int> CONST VAR 

%%
 
session
    : { print_welcome(); } 
      eval 
    ;

eval
    : eval line			{printf("%4ld: ",expr_count);}
    | /* empty */		{printf("%4ld: ",expr_count);}
    ;

line
    : assign '\n'		{ printf("%ld\n", $1); }
    ;

assign
    : VAR '=' expr		{check_error ($3); clear_vals(); value = eval($3); set_val($1, value); $$ = value; expr_count++;}
    | expr			   {check_error($1); $$ = eval($1); expr_count++;}
    | '\n'			   {yyerror("syntax error");return 1;}
    ;

expr
    : expr '+' term		{ $$ = make_binop_node($1, $3, ADD); }
    | expr '-' term		{ $$ = make_binop_node($1,$3,SUB); }
    | term
    ;

term
    : term '*' factor		{ $$ = $$ = make_binop_node($1,$3,MULT); }
    | term '/' factor		{ $$ = $$ = make_binop_node($1,$3,DIV); }
    | term '%' factor		{ $$ = $$ = make_binop_node($1,$3,MOD); }
    | factor
    ;

factor
    : '(' expr ')'		{$$ = $2;}
    | CONST         {$$ = make_const_node($1);}
    | VAR			{ $$ = make_var_node($1);}
    | '-' factor    {$$ = make_unop_node($2,MINUS);}
    | '+' factor	{$$ = make_unop_node($2, PLUS);}  
    | '#' CONST     {check_range ($2); $$= get_expression($2); cache_flag = TRUE; cache_val = $2;} 
    | '#' VAR       {yyerror("syntax error"); return 1;}
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

static int var_tab[26];

long get_val(long v)
{
    return var_tab[v - 'A'];
}

void set_val(long v, long val)
{
    var_tab[v - 'A'] = val;
}

void clear_vals()
{
    int i; 
    for (i=0; i<tab_size; i++)
    {
        mem_cache[i] = 0; 
    }   
} 
int check_range(long value)
{
    if (value > expr_count)
    {
        fprintf(stderr, "Index %ld is out of range", value);
        return 1; 
    } 
    return 0;  
}
int check_error(TN node)
{
    if (node == NULL)
    {
        yyerror("Node not found"); 
        return 1; 
    }

    return 0;     
}

