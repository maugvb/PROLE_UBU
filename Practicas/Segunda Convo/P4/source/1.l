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


"if" { return IF; }
"then" { return THEN; }
"endif" { return ENDIF; }
"else" { return ELSE; }
"while" { return WHILE; }
"do"   { return DO; }
"for" { return FOR; }
"from" { return FROM; }
"to" { return TO; }
"step" { return STEP; }
"begin" { return BEGIN; }
"end" { return END; }
"print" { return PRINT; }
";" { return SEMICOL; }
"+" { return ADD; }
"-" { return SUB; }
"*" { return MUL; }
"/" { return DIV; }
"(" { return PARENTHESIS_START; }
")" { return PARENTHESIS_END; }
"<-" { return ARROW; }


{ALPHA}({ALPHA}|{NUM})* { 
                            yylval.string = strdup(yytext); 
                            return ID;
                        }




.   return yytext[0];/* ignore unknown chars */


%%

