%{
    #include "y.tab.h"
%}
%%
[a-z]+ {yylval=4; return W;}
[0-9]+ {yylval=2; return N;}
.   ;
%%