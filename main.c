/*@ Title  main.c - Driver 
* @author  Christian Merchant
* @class   CSCE531
* @Project Bison Project
* @date    03-04-15
*/

int yyparse();

int main()
{
    extern int yydebug;
    yydebug = 0;         /* change to 1 to see debugging info */
    yyparse();
    return 0;
}
