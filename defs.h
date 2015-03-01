/*@Title   defs.h
* @author  Christian Merchant
* @class   CSCE531
* @Project Bison Project
* @date    03-04-15
*/



typedef enum {NULL_OP, UN_OP, BIN_OP, CONST, VAR} tagtype; 
typedef enum {UN_PLUS, UN_MINUS, INC, DEC} unop_type; 
typedef enum {BIN_PLUS, BIN_MINUS, MULT, DIV, MOD} binop_type; 

typedef struct tn
{
	tagtype tag; 
	union 
	{
		struct 
		{
			unop_type op; 
			struct tn *operand; 
		} unop;
		struct 
		{
			binop_type op;
			struct tn *left_operand; 
			struct tn *right_operand; 
		} binop; 
		long int_const; 
		int var; 
	}u; 	
} TREENODE, *TN; 

TN make_unop_node(TN node, int tag);
TN make_binop_node(TN tnode1, TN tnode2, int tag);
TN make_const_node(long val);
TN make_var_node(int variable); 

test test test test