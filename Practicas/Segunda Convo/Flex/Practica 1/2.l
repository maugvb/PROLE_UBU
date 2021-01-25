/*Definiciones*/
%{
#include <stdio.h> 
#include <string.h>
%}

%{
char class_max_methods[100], class_max_atr[100], *classes[50][100];
char auxClas[50];
int numClasses = 0;
int auxRep = 0;

%}

%x Class Relation 
CLASSNAME   [A-Za-z0-9]+


/*Reglas*/

%%
"["{CLASSNAME}"]"   {   
                            for(int i=1; i<yyleng;i++){
                                if(i!=yyleng-1){
                                 auxClas[i-1]=yytext[i];

                                }
                            }
                            
                            printf("Esta es la clase %s", auxClas);
                    }
.                   ;
%%
/*Codigo de usuario*/

int main(){
    yylex();

    printf("El número de clases es %d. \n", numClasses);
}