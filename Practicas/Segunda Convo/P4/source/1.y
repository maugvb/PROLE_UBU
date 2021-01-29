%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror( char *s);
extern FILE *yyin;
static int labelCount = 0;


int getNewLabel() {
    return labelCount++;
}

struct LabelPayload {
    int currentLabel;
    int endLabel;
};

%}


%union {
    int value;
    char *string;
    struct LabelPayload *payload;
}


%token PARENTHESIS_START PARENTHESIS_END ARROW DIV MUL SUB ADD SEMICOL PRINT END BEGINTK STEP TO FROM FOR DO WHILE ELSE ENDIF THEN IF
%token <value> NUME
%token <string> ID
%%


prop: ID 
        {printf("\tvalori %s\n", $<string>1);} 
                                                ARROW arithexp
                                                                {printf("\tasigna\n");}
    |   IF arithexp ifOptional
 
                                                                        
                                                                                                        
    |   WHILE 
              {int label = getNewLabel(); 
               $<value>$=label;
               printf("\nLBL%d\n",label);} 
                                            arithexp
                                                    {int label = getNewLabel();
                                                     $<value>$=label;
                                                     printf("\tsifalsovea LBL%d\n",label);} 
                                                                                            DO prop 
                                                                                                    {printf("\tvea LBL%d\n", $<value>2);
                                                                                                     printf("\nLBL%d\n",$<value>4);}
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
                                                                         } forEnum
                                                                                                                
    |   BEGINTK lprop END

    |   PRINT arithexp {printf("\tprint\n");}
    ;

ifOptional: THEN prop { int label = getNewLabel(); 
                        $<value>$=label; 
                        printf("\tvea LBL%d\n",label);}  ENDIF {printf("LBL%d\n", $<value>3);} 
    |      {int label = getNewLabel(); 
            $<value>$=label; 
            printf("\tsifalsovea LBL%d\n",label);}
                                                    THEN prop{  int label = getNewLabel(); 
                                                                $<value>$=label; 
                                                                printf("\tvea LBL%d\n",label);} 
                                                                                                ELSE 
                                                                                                    {printf("LBLL%d\n", $<value>1);} 
                                                                                                                                        prop 
                                                                                                                                                {printf("LBL%d\n", $<value>4);}
                                                                                                                                                                                    ENDIF 

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


lprop: prop SEMICOL lprop 
    |  prop 
    ;

arithexp: arithexp ADD term {printf("\tsum\n");}
   |    arithexp SUB term {printf("\tsub\n");}
   |    term 
   ;

term: term MUL fact {printf("\tmul\n");}
    |  term DIV fact {printf("\tdiv\n");}
    | fact
    ;

fact: ID {printf("\tvalord %s\n", $1);}
    |   NUME { printf("\tmete %d\n", $1); }
    |   PARENTHESIS_START arithexp PARENTHESIS_END
    ;






%%

void yyerror( char *s) { 



    extern int yylineno;
    extern char yytext[];

    fprintf(stderr, "%s in line %d near <%s>\n", s, yylineno, yytext);
    exit(-1);

    }
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
