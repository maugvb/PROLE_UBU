%{
    int lines = 0, letras = 0;
    let [a-zA-Z];
%}

%%
{let} {letras++;}
\n      {if(letras<30) lines++;
                letras = 0;
            }
.       ;
%%


int main() {
    yylex();
    printf("%d lineas de menos de 30 caracteres\n", lines);
}