/*Definiciones*/
%{
#include <stdio.h> 
#include <string.h>
/**
 * Declaraciones del parser
 *
 * @author <a href="mailto:mdg1007@alu.ubu.es">Mauricio De Armas Garcia-Valdecasas</a>
 */
%}

%{

/**
 * Definiciones de la varibales
 */
char classes[50][50], auxClass[50], claseAnterior[50], maxMethod[50], auxMaxMethod[50], classMaxMethod[50], actualClass[50], estereotipoAnterior[50], estereotipos[50][50];
int attr[50], met[50], par[50], numClasses = 0, numRels = 0, numEster=0, notes=0, numPar=0, numParAux=0, numMet=0, numMetAux=0;
int auxRep = 0, indexAux =0, mayorAttr, mayorMet;
int posMayorAttr = 0, posMayorMet=0;


%}
%x CLASS MEMBERS METHODS PAR NOTE ESTEROTIPOS
NAME   [A-Za-z0-9]+
SPECIAL ("+"|"-"|":"" "?|"_")
REL (">"|"<"|"+"|[0-1]|"-"|"."|" "?"orders"" "?|"^"|"*")+


/*Reglas*/
%%

"//".*  ;

"[note:"    {   notes++;
                BEGIN(NOTE);}
"[" BEGIN(CLASS);

<CLASS>"|"  BEGIN(MEMBERS);
<METHODS>"(" BEGIN(PAR);
<MEMBERS>"|"    BEGIN(METHODS);
<CLASS>"<<"   BEGIN(ESTEROTIPOS);
<ESTEROTIPOS>">>;" BEGIN(CLASS);
<METHODS>"]"   BEGIN(INITIAL);
<MEMBERS>"]"   BEGIN(INITIAL);
<CLASS>"]"  BEGIN(INITIAL);
<PAR>")"   {               


                if(numPar<numParAux){
                    strcpy(maxMethod, auxMaxMethod);
                    numPar=numParAux;
                    strcpy(classMaxMethod,actualClass);
                }
                numParAux=0;
                BEGIN(METHODS);
                
            }
<NOTE>"]" BEGIN(INITIAL);







<MEMBERS>{SPECIAL}?{NAME}{SPECIAL}?{NAME} {

    for(int i =0;i<numClasses;i++){
        if(strcmp(classes[i],claseAnterior)==0){
            indexAux=i;
        }
    }

    attr[indexAux]++;

}

<METHODS>";"    {
        if(numPar<numParAux){
                    strcpy(maxMethod, auxMaxMethod);
                    numPar=numParAux;
                    strcpy(classMaxMethod,actualClass);

                    
                }


                numParAux=0;
                BEGIN(METHODS);

}
<METHODS>":"{NAME}  ;

<METHODS>{SPECIAL}?{NAME} {
        numMet++;
        
        strcpy(auxMaxMethod, yytext);
        
        for(int i =0;i<numClasses;i++){
            if(strcmp(classes[i],claseAnterior)==0){
                indexAux=i;
            }
        }

        met[indexAux]++;
        BEGIN(PAR);
}
<METHODS>. ;

<PAR>":"{NAME}  ;
<PAR>","    {
                
}
<PAR>{NAME} {
    
    numParAux++;
}



<ESTEROTIPOS>{NAME} {


                        strcpy(estereotipoAnterior, yytext);
                        if(numEster==0){
                               strcpy(estereotipos[numEster], yytext);
                               numEster++;

                            }else{
                                for(int i=0; i<numEster;i++){
                                    if(strcmp(estereotipos[i],yytext)==0){
                                        auxRep = 1;
                                    }
                                }  

                                if(auxRep==0){
                                    strcpy(estereotipos[numEster], yytext);
                                    numEster++;

                                }else{
                                    auxRep=0;
                                }
                            }
}

<CLASS>{NAME} {

                        strcpy(claseAnterior,yytext);
                        strcpy(actualClass, yytext);
                        if(numClasses==0){
                               strcpy(classes[numClasses], yytext);
                               numClasses++;

                            }else{
                                for(int i=0; i<numClasses;i++){
                                    if(strcmp(classes[i],yytext)==0){
                                        auxRep = 1;
                                    }
                                }  

                                if(auxRep==0){
                                    strcpy(classes[numClasses], yytext);
                                    numClasses++;

                                }else{
                                    auxRep=0;
                                }
                            }
                                            
                            

                    }



" "?{REL}" "?    {
                        numRels++;
                    }
<NOTE>. ;
<METHODS>.  ;
<CLASS>.    ;
<ESTEROTIPOS>.  ;
<PAR>.   ;
<MEMBERS>.  ;
.                   ;
%%
/*Codigo de usuario*/
/*Main que llama al parser.*/
int main(int argc, char **argv){
    if(argc > 1) {
		FILE *file = fopen(argv[1], "r");
		if(!file) {
			fprintf(stderr, "no se puede abrir %s\n", argv[1]);
			exit(1);
		}
		yyin = file;
	}
    yylex();

    printf("El número de clases es %d y con estereotipo %i. \n", numClasses, numEster);
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

    printf("La clase con el mayor número de atributos es '%s', con %d atributos.\n", classes[posMayorAttr], mayorAttr);
    
    printf("El método con más argumentos es '%s' de la clase '%s'\n",maxMethod, classMaxMethod);

    printf("El número de notas es %d.\n", notes);
    

}