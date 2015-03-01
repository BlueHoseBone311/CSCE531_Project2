/*@Title   routines_bison.c - Helper routines used in rules of parse.y
* @author  Christian Merchant
* @class   CSCE531
* @Project Bison Project
* @date    03-04-15
*/
#include "defs.h"

void make_binop_node(TN tnode1, TN tnode2, int tag);
void make_const_node(long val);
void 