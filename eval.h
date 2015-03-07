/* @Title   eval.h - Tree evaluation functions, table functions ()
 * @author  Christian Merchant
 * @class   CSCE531
 * @Project Bison Project
 * @date    03-06-15
 */
#ifndef _EVAL_H_
#define _EVAL_H_

 #include "tree.h" 

void init_tabs(); 
long eval(TN node); 
void chk_or_resize(); 

#endif 

