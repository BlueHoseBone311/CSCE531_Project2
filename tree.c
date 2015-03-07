/* @Title   tree.c - Tree Functions
 * @author  Christian Merchant
 * @class   CSCE531
 * @Project Bison Project
 * @date    03-06-15
 */
#include <stdlib.h>
#include <stdio.h>
#include "tree.h"
#include "defs.h" 

TN make_binop_node(TN node1, TN node2, int tagtype)
{
	TN node = (TN) malloc(sizeof(TREENODE));
	node->tag = BIN_OP;

	if (!node)
	{
		fprintf(stderr, "out of space\n");
		exit(0);
	}	
	node->u.binop.tp = tagtype; 
	node->u.binop.left_operand = node1; 
	node->u.binop.right_operand = node2; 
	return node; 
}
TN make_unop_node(TN node1, int tagtype)
{
	TN node = (TN) malloc(sizeof(TREENODE));
	node->tag = UN_OP; 

	if (!node)
	{
		fprintf(stderr, "out of space\n");
		exit(0);
	}	
	node->u.unop.op = tagtype; 
	node->u.unop.operand = node1; 
	return node; 
}

TN make_const_node(long val)
{
	TN node = (TN) malloc(sizeof(TREENODE));
	node->tag = C; 
	if (!node)
	{
		fprintf(stderr, "out of space\n");
		exit(0);
	}	
	node->u.int_const = val; 
	return node; 
}

TN make_var_node(char variable)
{
	TN node = (TN) malloc(sizeof(TREENODE));
	node->tag = V; 
	if (!node)
	{
		fprintf(stderr, "out of space\n");
		exit(0);
	}	
	node->u.var = variable;
	return node;  
}

TN get_expression(int index)
{
	TN node = expr_tab[index]; 
	return node; 
}