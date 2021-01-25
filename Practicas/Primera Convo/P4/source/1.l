%{
#include "y.tab.h"
#include <string.h>
%}




ALPHA [a-zA-Z]
NUM [0-9]
%%
[ \t\r\n]           ;
"**".*   ;

{NUM}+      {    
    yylval.value = atoi(yytext);
    return NUME;
}


"COMPUTE" { return COMPUTE;}
"=" { return EQUAL;}
"MOVE" { return MOVE;}
"TO" { return TO;}
"IF" { return IF;}
"THEN" { return THEN;}
"EVALUATE" { return EVALUATE;}
"END-EVALUATE" { return END_EVALUATE;}
"PERFORM" { return PERFORM;}
"UNTIL" { return UNTIL;}
"END-PERFORM" { return END_PERFORM;}
"DISPLAY" { return DISPLAY;}
"ELSE" { return ELSE;}
"END-IF" { return END_IF;}
"WHEN" { return WHEN;}
"+" { return ADD;}
"-" { return SUB;}
"*" { return MUL;}
"/" { return DIV;}
"(" { return PARENTHESIS_START;}
")" { return PARENTHESIS_END;}
{ALPHA}({ALPHA}|{NUM})* { 
                            yylval.string = strdup(yytext); 
                            return ID;
                        }




.   return yytext[0];/* ignore unknown chars */


%%

