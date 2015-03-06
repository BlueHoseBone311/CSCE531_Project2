/*@ Title  main.c - Driver 
* @author  Christian Merchant
* @class   CSCE531
* @Project Bison Project
* @date    03-06-15
*/
#include "eval.h" 
int yyparse();

int main()
{
    extern int yydebug;
    yydebug = 0;         /* change to 1 to see debugging info */
    init_tabs(); 
    yyparse();
    return 0;
}
