/* @Title   tree.h - Tree fuctions header file
 * @author  Christian Merchant
 * @class   CSCE531
 * @Project Bison Project
 * @date    03-06-15
 */


//Tree node structures and enumerations 
typedef enum {UN_OP, BIN_OP, C, V}tagtp; 
typedef enum {PLUS,MINUS}unop_type; 
typedef enum {MULT, DIV, ADD, SUB, MOD}binop_type; 

typedef struct tn{
	tagtp tag; 
	union{
		struct{
			unop_type op; 
			struct tn *operand;
		}unop; 
		struct{
			binop_type tp;
			struct tn *left_operand;
			struct tn *right_operand; 
		}binop;
		long int_const; 
		char var; 
	}u;
}TREENODE, *TN; 

//Table Declarations
TN expr_tab; 




//Tree Methods
TN make_binop_node(TN node1, TN node2, int tagtype);
TN make_unop_node(TN node1, int tagtype); 
TN make_const_node(long val);
TN make_var_node(char var);
TN get_expression(int index); 