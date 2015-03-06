/*@Title   scan.l  - flex file
* @author  Christian Merchant
* @class   CSCE531
* @Project Bison Project
* @date    03-06-15
*/

%{
#include <math.h>
#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include "defs.h"
#include "eval.h"
#include "tree.h"
#include "y.tab.h"
%}
whtspc	    [ \t]+ 
int_const   [0-9]+
letter      [a-zA-Z]
synerr      [*][*]+|[/][/]+|[-][-]+|[+][+]+|[-]+[*]+|[*]+[-]+|[/]+[*]+|[*]+[/]+
 


%%
{whtspc}			/*consume whitespace*/

{int_const}	   {
                    yylval.y_int = atol(yytext);
                    return CONST; 
                   }

{letter}        {
                   yylval.y_int = (long)toupper(yytext[0]); 
                   return VAR; 
                } 
{synerr}        {return 1;}                
.|\n              {return yytext[0];} 
 
              
%%
