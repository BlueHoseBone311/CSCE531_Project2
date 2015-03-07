#include <stdlib.h>
#include <stdio.h>
#include "tree.h"
#include "defs.h"
#include "eval.h"
int tab_size = 0;
/*Sets the initial table sizes*/
void init_tabs()
{
	tab_size = 10; 
	expr_tab = NULL; 
	mem_cache = NULL; 
	expr_tab = (TN *) malloc(tab_size * sizeof(TN));
	mem_cache = (long *) malloc(tab_size * sizeof(long));
}
/* Method to evalue a tree node. Recursively walks the tree computing attributes of subtrees
   If the cache_flag is set, the value of the 

 */
long eval (TN node)
{
    chk_or_resize(); 
    expr_tab[expr_count] = node;
    long calc = 0; 

    if (cache_flag == FALSE || cache_val == 0 || mem_cache[cache_val] == 0 && node != NULL)
    {
		if (node->tag == UN_OP) //Unary operation case
		{
			switch(node->u.unop.op)
			{
				case MINUS: calc = -eval(node->u.unop.operand); break;
				case PLUS: calc = eval(node->u.unop.operand); break;
				default: yyerror("error: bad node\n");
			}
		}

		else if (node->tag == BIN_OP) //Binary Operation case
		{
			switch(node->u.binop.tp)
			{
				case MULT: calc = eval(node->u.binop.left_operand) * eval(node->u.binop.right_operand); break;
				case DIV: calc = eval(node->u.binop.left_operand) / eval(node->u.binop.right_operand); break;
				case ADD: calc = eval(node->u.binop.left_operand) + eval(node->u.binop.right_operand); break;
				case SUB: calc = eval(node->u.binop.left_operand) - eval(node->u.binop.right_operand); break;
				case MOD: calc = eval(node->u.binop.left_operand) % eval(node->u.binop.right_operand); break;
				default: fprintf(stderr, "error: bad node\n");
			}
		}

		else if (node->tag == C) //constant case
		{
			calc = node->u.int_const;
		}
		else //variable case
		{
			calc = get_val(node->u.var); 
		}
	
    }
    else if(cache_flag == TRUE && cache_val != 0 && mem_cache[cache_val] != 0 && node != NULL)
    {
    	calc = mem_cache[cache_val];
    	mem_cache[expr_count] = calc; 
    	cache_flag = FALSE; 
    	cache_val = 0;  
    }
    else
    {
    	fprintf(stderr, "%s\n", "Internal error: bad node"); 
    }	

    return calc; 
}

void chk_or_resize()
{
	if (expr_count>=tab_size)
    {
		int tab_size = expr_count*2; 
		expr_tab = (TN *) realloc(expr_tab, tab_size*sizeof(TN));
		mem_cache = (long *) realloc (mem_cache, tab_size*sizeof(long));
		free(expr_tab); 
		free(mem_cache); 
    }	
}   








