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

    if (cache_flag == FALSE || cache_val == 0 || memcache_flag == TRUE)
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
    
    else if(cache_flag == TRUE && cache_val != 0 && memcache_flag == FALSE)
    {
    	calc = mem_cache[cache_val];
    	cache_flag = FALSE; 
    	cache_val = 0;  
    	memcache_flag = FALSE; 
    }
    
    else
    {
    	fprintf(stderr, "%s\n", "Internal error: bad node"); 
    }	

    mem_cache[expr_count] = calc; 
    return calc; 
}

void chk_or_resize()
{
	if (expr_count>=tab_size)
    {
    	int i; 
    	int temp = tab_size; 
		int tab_size = expr_count*2; 
		TN * temp1;
		long * temp2; 
		temp1 = (TN *) malloc(tab_size*sizeof(TN));
		temp2 = (long *) malloc (tab_size*sizeof(long));
		if (!temp1 || ! temp2)
		{
			fprintf(stderr, "Table resizing failed");
			exit(0);
		}
		for (i=1; i<temp; i++)
		{
			temp1[i] = expr_tab[i];
			temp2[i] = mem_cache[i];
		}
		free(expr_tab); 
		free(mem_cache); 	
		expr_tab = temp1; 
		mem_cache = temp2; 	
		
    }	
}  
#ifdef LOOKUPFUNCT
long lookup(TN tnode)
{
	long val = 0;
	int i;  
	for (i=0; i<tab_size; i++)
	{
		if (tnode == expr_tab[i])
		{
			val = mem_cache[i];
		}	
	}	
	return val; 
} 
#endif







