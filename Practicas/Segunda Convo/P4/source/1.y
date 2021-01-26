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


%token PARENTHESIS_START PARENTHESIS_END ARROW DIV MUL SUB ADD SEMICOL PRINT END BEGIN STEP TO FROM FOR DO WHILE ELSE ENDIF THEN IF
%token <value> NUME
%token <string> ID
%%




prop: ID ARROW arithexp
    |   IF arithexp THEN prop ENDIF
    |   IF arithexp THEN prop ELSE prop ENFIF
    |   WHILE arithexp DO prop
    |   FOR ID FROM NUME TO arithexp DO prop
    |   FOR ID FROM NUME TO arithexp STEP NUME DO prop
    |   BEGIN lprop END
    |   PRINT arithexp
    ;


prop_epsilon:


lprop: prop SEMICOL lprop
    |  prop
    ;

arithexp: arithexp ADD term
   |    arithexp SUB term
   |    term 
   ;

term: term MUL fact
    |  term DIV fact
    | fact
    ;

fact: ID
    |   NUME
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
