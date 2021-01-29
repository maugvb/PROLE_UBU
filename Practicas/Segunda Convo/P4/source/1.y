%{
#include <stdio.h>
#include <stdlib.h>
/**
 * Clase del parser.
 *
 * @author <a href="mailto:mdg1007@alu.ubu.es">Mauricio De Armas Garcia-Valdecasas</a>
 */
int yylex();
/**
 *   Handler de los errores sintacticos del parser.
 */
void yyerror( char *s);
/**
*   Archivo de texto.
*/
extern FILE *yyin;
/**
*   Contador de labels.
*/
int labelCount=0;
/**
*   Funcion que retorna la proxima label.
*/
int getNewLabel() {
    return labelCount++;
}

%}


%union {
    int value;
    char *string;
}


%token PARENTHESIS_START PARENTHESIS_END ARROW DIV MUL SUB ADD SEMICOL PRINT END BEGINTK STEP TO FROM FOR DO WHILE ELSE ENDIF THEN IF
%token <value> NUME
%token <string> ID
%%

/**
* No terminal que identifica la gramatica general. (If, while, for, begin, print, <-).
*/
prop: ID 
        {printf("\tvalori %s\n", $<string>1);} 
                                                ARROW arithexp
                                                                {printf("\tasigna\n");}
    |   IF arithexp {int label = getNewLabel(); 
             $<value>$=label; 
             printf("\tsifalsovea LBL%d\n",label);} THEN prop {int label = getNewLabel(); $<value>$=label; printf("\tvea LBL%d\n",label);}  ifOptional
 
                                                                        
                                                                                                        
    |   WHILE 
              {int label = getNewLabel(); 
               $<value>$=label;
               printf("LBL%d\n",label);} 
                                            arithexp
                                                    {int label = getNewLabel();
                                                     $<value>$=label;
                                                     printf("\tsifalsovea LBL%d\n",label);} 
                                                                                            DO prop 
                                                                                                    {printf("\tvea LBL%d\n", $<value>2);
                                                                                                     printf("LBL%d\n",$<value>4);}
    |   FOR  ID FROM NUME 
                            {printf("\tvalori %s\n", $2);
                             printf("\tmete %d\n", $<value>4);
                             printf("\tasigna\n");
                             int label = getNewLabel();
                             $<value>$=label;
                             printf("LBL%d\n",label);
                             printf("\tvalori %s\n",$2);} 
                                                            TO arithexp 
                                                                        {printf("\tsub\n");
                                                                         int label = getNewLabel(); 
                                                                         $<value>$=label;
                                                                         printf("\tsifalsovea LBL%d\n",label);} forEnum
                                                                                                                
    |   BEGINTK lprop END

    |   PRINT arithexp {printf("\tprint\n");}
    ;
/**
* No terminal que factoriza las operaciones IF de la gramatica.
*/
ifOptional:  
               ELSE {printf("LBL%d\n", $<value>-3);}
               prop {printf("LBL%d\n", $<value>0); }
            ENDIF                                                                                                 
    |     {printf("LBL%d\n", $<value>-3); printf("LBL%d\n", $<value>0);}
           ENDIF 
/**
* No terminal factoriza las operaciones FOR de la gramatica.
*/
forEnum: STEP NUME DO prop 
                            {printf("\tvalori %s\n",$<string>-6);
                             printf("\tvalord %s\n",$<string>-6);
                             printf("\tmete %d\n",$<value>2);
                             printf("\tsum\n");
                             printf("\tasigna\n");
                             printf("\tvea LBL%d\n", $<value>-3);
                             printf("LBL%d\n", $<value>0);}
    | DO prop 
                {printf("\tvalori %s\n",$<string>-6);
                 printf("\tvalord %s\n",$<string>-6);
                 printf("\tmete 1\n");
                 printf("\tsum\n");
                 printf("\tasigna\n");
                 printf("\tvea LBL%d\n", $<value>-3);
                 printf("LBL%d\n", $<value>0);}

/**
* No terminal que identifica las sentencias con punto y coma.
*/
lprop: prop SEMICOL lprop 
    |  prop 
    ;
/**
*No terminal que identifica las operaciones de Suma y resta.
*/
arithexp: arithexp ADD term {printf("\tsum\n");}
   |    arithexp SUB term {printf("\tsub\n");}
   |    term 
   ;

/**
* No terminal que identifica las operaciones de de multiplicación y división. 
*/
term: term MUL fact {printf("\tmul\n");}
    |  term DIV fact {printf("\tdiv\n");}
    | fact
    ;
/**
* No terminal que identifica los datos finales.
*/
fact: ID {printf("\tvalord %s\n", $1);}
    |   NUME { printf("\tmete %d\n", $1); }
    |   PARENTHESIS_START arithexp PARENTHESIS_END
    ;






%%
/**
 *   Handler de los errores sintacticos del parser.
 */
void yyerror( char *s) { 



    extern int yylineno;
    extern char yytext[];

    fprintf(stderr, "%s in line %d near <%s>\n", s, yylineno, yytext);
    exit(-1);

    }
/**
*
*
*   Funcion Main del programa que lanza yyparse(); 
*   Se abre el archivo con el texto a parsear y se lanza el parser.
*
*/
int main(int argc, char **argv){ 
    if(argc > 1) {
		FILE *file = fopen(argv[1], "r");
		if(!file) {
			fprintf(stderr, "no se puede abrir %s\n", argv[1]);
			exit(1);
		}
		yyin = file;
	}
    yyparse(); 
}
