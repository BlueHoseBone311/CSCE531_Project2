/*@Title   defs.h  - general header file
* @author  Christian Merchant
* @class   CSCE531
* @Project Bison Project
* @date    03-06-15
*/
#ifndef _DEFS_H_
#define _DEFS_H_

typedef int boolean;
#define TRUE 1
#define FALSE 0

//Defines the dynamically allocated array holding values from #int statments
long * mem_cache;

//expression counter, flag for setting whether # CONST has been see, and cache_val for storing the line number it references
long expr_count;
boolean cache_flag;
boolean memcache_flag; 
long cache_val;
int tab_size;   

//methods for getting value from var_tab and resizing expression array and mem_cache array
void clear_vals();  
long get_val(long v); 

#endif 