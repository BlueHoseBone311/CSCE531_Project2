/*@Title   scan.l  - flex file
* @author  Christian Merchant
* @class   CSCE531
* @Project Bison Project
* @date    03-04-15
*/

%{
#include "defs.h"
#include "y.tab.h"
%}


%%
%%
int yylex()
{
    int c;

    /* read past whitespace first */
    while ((c = getchar()) == ' ' || c == '\t');

    if (isalpha(c))            /* if letter (variable name) */
    {
        yylval = toupper(c);   /* case insensitive */
        return VAR;
    }
    if (isdigit(c))
    {
        ungetc(c, stdin);
        scanf("%d", &yylval);
        return CONST;
    }
    return c;
}