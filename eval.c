#include <stdlib.h>
#include <stdio.h>
#include "tree.h"
#include "defs.h"
#include "eval.h"

void init_tabs()
{
	h_size = 0;
    hash_tab = NULL;
    resize(INITIAL_HASH_SIZE);
	tab_size = 10; 
	expr_tab = NULL; 
	mem_cache = NULL: 
	expr_tab = (TN *) malloc(tab_size * sizeof(TN));
	mem_cache = (long *) malloc(tab_size * sizeof(long));
}
long eval (TN node)
{
    chk_or_resize(); 
    expr_tab[expr_count] = node;
    long calc = 0; 
    
    if (cache_flag == FALSE || cache_val == 0 && node != NULL)
    {
		if (node->u.tag == UN_OP)
		{
			switch(node->u.unop.op)
			{
				case MINUS: calc = -eval(node->u.unop.operand); break;
				case PLUS: calc = eval(node->u.unop.operand); break;
				default: yyerror("error: bad node %d\n", node->u.tag);
			}
		}

		else if (node->u.tag == BIN_OP)
		{
			switch(node->u.binop.tp)
			{
				case MULT: calc = eval(node->u.binop.left_operand) * eval(node->u.binop.right_operand); break;
				case DIV: calc = eval(node->u.binop.left_operand) / eval(node->u.binop.right_operand); break;
				case ADD: calc = eval(node->u.binop.left_operand) + eval(node->u.binop.right_operand); break;
				case SUB: calc = eval(node->u.binop.left_operand) - eval(node->u.binop.right_operand); break;
				case MOD: calc = eval(node->u.binop.left_operand) % eval(node->u.binop.right_operand); break;
				default: yyerror("error: bad node %d\n", node->u.tag);
			}
		}

		else if (node->u.tag == C) //constant case
		{
			calc = node->u.int_const;
		}
		else //variable case
		{
			calc = get_val(node->u.var); 
		}
	
    }
    else if(cache_flag == TRUE && cache_val != 0 && node != NULL)
    {
    	calc = mem_cache[cache_val];
    	cache_flag = FALSE; 
    	cache_val = 0;  
    }
    else
    {

    }	

    mem_cache[expr_count] = calc; 

    return calc; 
}

void chk_or_resize()
{
	if (expr_count>=tab_size)
    {
		int new_size = expr_count*2; 
		expr_tab = (TN *) realloc(expr_tab, new_size*sizeof(TN));
		mem_cache = (long *) realloc (mem_cache, new_size*sizeof(long));
		free(expr_tab); 
		free(mem_cache); 
    }	
}   








