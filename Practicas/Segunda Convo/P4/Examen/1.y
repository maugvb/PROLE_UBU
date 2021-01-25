%{
#include <stdio.h>
int yylex();
void yyerror( char *s);
%}


%token N W
%%
lst: N {$$ = 10;} W noterm {printf("%d", $2+$3);}
noterm: N { $$ = $1+$-1;}

%%

void yyerror(char *msg ){ printf("Err %sn", msg); }
void main (){yyparse();}