/* @Title   parse.y - Bison File
 * @author  Christian Merchant
 * @class   CSCE531
 * @Project Bison Project
 * @date    03-04-15
 */


%{
#include <ctype.h>
#include <tree.h>
#define YYDEBUG 1

int  get_val(int);
void set_val(int, int);
static int expr_count =1; 
%}
%union {
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
    : eval line			{printf("%4d: ",expr_count);}
    | /* empty */		{printf("%4d: ",expr_count);}
    ;

line
    : assign '\n'		{ printf("%d\n", $1); }
    ;

assign
    : VAR '=' expr		{ set_val($1, $3);  $$ = $3; expr_count++;}
    | expr			   {$$=$1; expr_count++;}
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
    | VAR			{ $$ = make_var_node(get_val($1)); }
    | '-' factor    {$$ = make_unop_node($2,MINUS);}
    | '+' factor	{$$ = make_unop_node($2, PLUS);}  
    | '#' CONST     {$$= get_expression($2);} 
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

static int val_tab[26];

int get_val(int v)
{
    return val_tab[v - 'A'];
}

void set_val(int v, int val)
{
    val_tab[v - 'A'] = val;
}

