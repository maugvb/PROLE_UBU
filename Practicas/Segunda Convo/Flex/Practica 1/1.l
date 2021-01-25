/*Definiciones*/
%{
#include <stdio.h> 
#include <string.h>
%}

%{


char classes[50][50], auxClass[50], claseAnterior[50];
int attr[50], met[50], numClasses = 0, numRels = 0;
int auxRep = 0, indexAux =0, mayorAttr, mayorMet;
int posMayorAttr = 0, posMayorMet=0;


%}
%x CLASS MEMBERS METHODS PAR NOTE
NAME   [A-Za-z0-9]+
SPECIAL ("+"|"-"|":"" "?)
REL (">"|"<"|"+"|[0-1]|"-"|"."|" "?"orders"" "?|"^"|"*")+


/*Reglas*/


%%


"//".*  ;

"[note:"    BEGIN(NOTE);
"[" BEGIN(CLASS);
<CLASS>"|"  BEGIN(MEMBERS);
<MEMBERS>"|"    BEGIN(METHODS);

<METHODS>"]"   BEGIN(INITIAL);
<MEMBERS>"]"   BEGIN(INITIAL);
<CLASS>"]"  BEGIN(INITIAL);
<PAR>")"   BEGIN(METHODS);
<NOTE>"]" BEGIN(INITIAL);




<MEMBERS>{SPECIAL}?{NAME}{SPECIAL}?{NAME} {

    for(int i =0;i<numClasses;i++){
        if(strcmp(classes[i],claseAnterior)==0){
            indexAux=i;
        }
    }

    attr[indexAux]++;

}


<METHODS>{SPECIAL}?{NAME}"(" {
        for(int i =0;i<numClasses;i++){
            if(strcmp(classes[i],claseAnterior)==0){
                indexAux=i;
            }
        }

        met[indexAux]++;
        BEGIN(PAR);
}
<PAR>{NAME} {
    printf("\n\nUn parametro %s\n\n", yytext);
}

<CLASS>{NAME} {
                        strcpy(claseAnterior,yytext);
                        if(numClasses==0){
                               strcpy(classes[numClasses], yytext);
                               numClasses++;
                               printf(" Esta clase se ha añadido correctamente: %s \n\n", yytext);

                            }else{
                                for(int i=0; i<numClasses;i++){
                                    if(strcmp(classes[i],yytext)==0){
                                        auxRep = 1;
                                    }
                                }  

                                if(auxRep==0){
                                    strcpy(classes[numClasses], yytext);
                                    numClasses++;
                                    printf(" Esta clase se ha añadido correctamente: %s \n\n", yytext);

                                }else{
                                    auxRep=0;
                                    printf(" Clase repetida ERROR al añadir %s \n\n", yytext);
                                }
                            }
                                            
                            

                    }



" "?{REL}" "?    {
                        numRels++;
                    }

.                   ;
%%
/*Codigo de usuario*/

int main(){

    yylex();

    for(int i=0; i<numClasses; i++){

        printf("\nClase: %s \n", classes[i]);
    }

    printf("El número de clases es %d. \n", numClasses);
    printf("El número de relaciones es %d. \n", numRels);
    



    mayorAttr = attr[0];
    mayorMet = met[0];

    for(int i = 1; i < numClasses; ++i)
    {
        if(attr[i] > mayorAttr)
        {
            mayorAttr = attr[i];
            posMayorAttr = i;
        }

        if(met[i] > mayorMet){
            mayorMet = met[i];
            posMayorMet = i;

        }
    }

    printf("La clase con el mayor número de atributos es %s, con %d atributos.\n", classes[posMayorAttr], mayorAttr);
    printf("La clase con el mayor número de metodos es %s, con %d metodos.\n", classes[posMayorMet], mayorMet);

}