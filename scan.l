/*@Title   scan.l  - flex file
* @author  Christian Merchant
* @class   CSCE531
* @Project Bison Project
* @date    03-04-15
*/

%{
#include <math.h>
#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include "y.tab.h"
%}
whtspc	    [ \t]+ 
int_const   [0-9]+
letter      [a-zA-Z]
assignment  "="
operator    [-+*/%]
paren       [()]
 


%%
{whtspc}			/*consume whitespace*/

{int_const}	   {
                    yylval.y_int = atol(yytext);
                    return CONST; 
                   }

{letter}        {
                   yylval.y_int = toupper(yytext[0]); 
                   return VAR; 
                } 

{assignment}	 {   
                   return yytext[0];  	
		 } 
{operator}	    {
		       return yytext[0];
		    }  
{paren}         {
                    return yytext[0];
                }  
.|\n		return yytext[0];                          
%%
