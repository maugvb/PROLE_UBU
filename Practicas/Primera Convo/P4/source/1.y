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

int getLabel(){
    return labelCount-1;
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


%token EQUAL COMPUTE MOVE TO IF THEN PARENTHESIS_START PARENTHESIS_END EVALUATE END_EVALUATE PERFORM WHEN UNTIL END_PERFORM DISPLAY ELSE END_IF ADD SUB MUL DIV
%token <value> NUME
%token <string> ID
%%


program: sentences;

sentences: sent sentences
    | sent;

sent: assig
    |  proc;

assig: COMPUTE ID{printf("\tvalori %s\n", $2);} EQUAL arithexp {printf("\tasigna\n");}
    |  proc_mov {printf("\tasigna\n");}
    ;

proc_mov: MOVE fac_mov

fac_mov: NUME TO ID {
                       printf("\tvalori %s\n", $3);
                       printf("\tmete %d\n", $1); 
                    }
    |  ID TO ID {   
                    printf("\tvalori %s\n", $3);
                    printf("\tvalord %s\n", $1);
                }
    ;

proc: IF arithexp sentences elseopt 
    |  EVALUATE newlabel ID {
                            printf("\tvalord %s\n", $3);
                            }  
                            
        whenclause {
            $<value>$ = $<value>2;
            printf("\tvea LBL%d\n", $<value>2); 
            printf("LBL%d\n", getLabel()); 
            printf("\tvalord %s\n", $3);
        }

        epsilonwhen END_EVALUATE 
    |  PERFORM UNTIL arithexp sentences END_PERFORM 
    |  displayclause{printf("\tprint\n");}
    ;

displayclause: DISPLAY arithexp;

elseopt: ELSE sentences END_IF 
    |  END_IF 
    ;

whenclause: WHEN arithexp {
            printf("\tsub\n");
            int label = getNewLabel();
            printf("\tsifalsevea LBL%d\n",label);
            } sentences;

epsilonwhen: WHEN arithexp{
            printf("\tsub\n");
            int label = getNewLabel();
            printf("\tsifalsevea LBL%d\n",label);} sentences {printf("\tvea LBL%d\n", $<value>-1); } epsilonwhen 
    | //EPSILON
    ;

arithexp: arithexp ADD multexp { printf("\tsum\n"); }
     |  arithexp SUB{ printf("\tsub\n"); } multexp 
     |  multexp	
     ;

multexp: multexp MUL value { printf("\tmul\n"); }
     |  multexp DIV value { printf("\tdiv\n"); }
     |  value	
     ;

newlabel:
    { $<value>$ = getNewLabel(); 
    }
    ;
value: NUME { printf("\tmete %d\n", $1); }
     | ID  { printf("\tvalord %s\n", $1); }
     | PARENTHESIS_START arithexp PARENTHESIS_END
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
