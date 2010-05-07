%{
	#include "headings.h"
	extern int yylineno;	// defined and maintained in lex.c
	extern char *yytext;	// defined and maintained in lex.c

	int yyerror(char *s);
	int yylex(void);
%}

%union
   { int code;
     double real;
     char *string;
     NODE node;
   }
 /* token definitions */ 

%token PROGRAM BBEGIN END  
%token OUTPUT INPUT   
%token EXECUTE CONNECT SCAN PRINT
%token PHASE NORTH SOUTH WEST EAST   
%token REGISTER VAR MESH DIM VOID
%token IF FI ELSE THEN   
%token IDE STRING INTCONST REALCONST
%token ADD MIN MUL DIV MOD LES LEQ EQU NEQ GRE GEQ   
%token AND OR NOT FALSE TRUE  	
%token ASSIGN   
%token LC RC   
/*TODO: procedure??????????????? */
%token PROCEDURE F_1UN F_2UN BIN PST   

%token<code> INTCONST
%token<string> IDE
%token<real> REALCONST
%token<string> STRING   

/* expresion suntax */
%%
/* Step Phases declaration */
readPhase:	'R'':' instractionSet						{$$ = makeNode(PHASE,NULL,NULL,$2,0,READ);}
			;
calcPhase:	'C'':' instractionSet						{$$ = makeNode(PHASE,NULL,NULL,$2,0,CULCULATE);}
			;
busPhase:	'B'':' instractionSet						{$$ = makeNode(PHASE,NULL,NULL,$2,0,BUS);}
			;
writePhase:	'W'':' instractionSet						{$$ = makeNode(PHASE,NULL,NULL,$2,0,WRITE);}
			;

/*TODO: maby seperate by newline*/
singleStep:	readPhase calcPhase busPhase writePhase 
			;
instractionSet: /* the instraction set for each phase of the step ,
				NOTE: the instraction set can pe empty/*

/* Varible definitions */

mesh_def:	MESH IDE dim dim	{}

dim:	'['INTCONST']''['INTCONST']'	{}
		;
registerName:	IDE 									{$$ = genLeaf(REGISTER,$1,NULL,IDE);}
				;
register_def:	REGISTER registerNames					{}
				;
registerNames: IDE','
				|IDE
				;
inputVector:	'Input' IDE dim							{$$ = makeNode(INPUT,$1,$3,NULL,0,NULL);}
				;
outputVector	'Output' IDE dim						{$$ = makeNode(OUTPUT,$1,$3,NULL,0,NULL);}
				;
expr:	expr ADD expr { $$ = makenode(ADD,$1,$3,NULL,0,NULL);}
		|expr MIN expr { $$ = makenode(MIN,$1,$3,NULL,0,NULL);}
		|expr MUL expr { $$ = makenode(MUL,$1,$3,NULL,0,NULL);}
		|expr DIV expr { $$ = makenode(DIV,$1,$3,NULL,0,NULL);}
		|expr MOD expr { $$ = makenode(MOD,$1,$3,NULL,0,NULL);}
		|expr LES expr { $$ = makenode(LES,$1,$3,NULL,0,NULL);}
		|expr LEQ expr { $$ = makenode(LEQ,$1,$3,NULL,0,NULL);}
		|expr EQU expr { $$ = makenode(EQU,$1,$3,NULL,0,NULL);}
		|expr NEQ expr { $$ = makenode(NEQ,$1,$3,NULL,0,NULL);}
		|expr GRE expr { $$ = makenode(GRE,$1,$3,NULL,0,NULL);}
		|expr GEQ expr { $$ = makenode(GEQ,$1,$3,NULL,0,NULL);}
		| '(' expr ')'               { $$ = $2; }
		| MIN atom %prec DUMMY    { $$ = makenode(MIN,$2,NULL,NULL,0,NULL); }
		| NOT atom                   { $$ =makenode(NOT,$2,NULL,NULL,0,NULL); }
		| atom                       { $$ = $1; }
		;

atom:   VAR                        { $$ = $1; }
      | INTCONST                   { $$ = genLeaf(INTCONST,$1,0,NULL); }
      | REALCONST                  { $$ = genLeaf(REALCONST,0,$1,NULL);}
      | TRUE                       { $$ = genLeaf(TRUE,0,0,NULL); }
      | FALSE                      { $$ = genLeaf(FALSE,0,0,NULL); }
      ;

%%




/* additional helper functions */
int yyerror(char* s)
{
	fprinff(stderr,"ERROR: %s in line %d at symbol",s,yylineno, yytext);
  	
  exit(1);
}



NODE genLeaf(int op, int val, double rval,char *id)
{
	printf ("The function %s is no yet Implemented\n ", "\"NODE genLeaf(int op, int val, double rval,char *id)\"");
	return NULL /*	Not implemented	*/
}
NODE makenode(int op, NODE s1, NODE s2, NODE s3,int val,char *id)
{
	printf ("The function %s is no yet Implemented\n ", "\"NODE makenode(int op, NODE s1, NODE s2, NODE s3,int val,char *id)\"");
	return NULL /*	Not implemented	*/
}
