%{
    int lines = 0;
%}

%%
(.)*\n  {if (yyleng <31) lines++;}
%%


int main() {
    yylex();
    printf("%d lineas de menos de 30 caracteres\n", lines);
}