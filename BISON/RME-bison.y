%{
	#include <stdio.h>
	#include <malloc.h>
	#include <string.h>
	#include "heading.h"
	extern int yylineno;	// defined and maintained in lex.c
	extern char *yytext;	// defined and maintained in lex.c
	int stepNum = 0;
	int line_number = 1;
	char buf[12];
	NODE root;
	NODE makenode(int op, NODE s1, NODE s2, NODE s3, NODE s4,int val,char *id);
	NODE genLeaf(int op, int val, double rval,char *id);
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

%token PROGRAM PBEGIN END STATAMENT 
%token VECTOR OUTPUT INPUT   
%token EXECUTE CONNECT SCAN PRINT
%token PHASE NORTH SOUTH WEST EAST   
%token REGISTER VAR MESH DIM VOID
%token IF FI ELSE THEN
%token ADD MIN MUL DIV MOD LES LEQ EQU NEQ GRE GEQ   
%token AND OR NOT FALSE TRUE  	
%token ASSIGN 
%token LC RC 
%token STEP CASE STATEMENT
/*TODO: procedure??????????????? */
%token PROCEDURE F_1UN F_2UN F_BIN F_PST   

%token<code> INTCONST
%token<string> IDE
%token<real> REALCONST
%token<string> STRING   


%type<node> program
%type<node> expr atom
%type<node> var_seq nextVar staeps_seq mesh_def register_def out_vec_def in_vec_def dim block singleVar
%type<node> readBlock calcBlock busBlock writeBlock stat_seq stat singleStep nextStep		
%type<node> readPhase calcPhase busPhase writePhase nextIDE nextVector vector
/* expresion suntax */


%nonassoc LES LEQ EQU NEQ GRE GEQ
%left ADD MIN OR MUL DIV AND MOD
%right NOT DUMMY

%start program

%%


program:	PROGRAM IDE var_seq staeps_seq END PROGRAM	{$$ = makenode(PROGRAM,$3,$4,NULL,NULL,0,NULL); root=$$;}
		;

var_seq:	VAR nextVar 					{$$ = makenode(VAR,$2,NULL,NULL,NULL,0,NULL);}
		;

singleVar:	 mesh_def 					{$$ = makenode(MESH,$1,NULL,NULL,NULL,0,NULL);}
			|register_def 				{$$ = makenode(REGISTER,$1,NULL,NULL,NULL,0,NULL);}
			|out_vec_def				{$$ = makenode(OUTPUT,$1,NULL,NULL,NULL,0,NULL);}
			|in_vec_def 				{$$ = makenode(INPUT,$1,NULL,NULL,NULL,0,NULL);}
		;		
nextVar:	 nextVar  singleVar ';'     { $$ = makenode(VAR,$1,$2,NULL,NULL,0,NULL);}
			|singleVar ';'				{$$ = makenode(VAR,$1,NULL,NULL,NULL,0,NULL);}
		;
/* mesh definition can be only one */
mesh_def:	MESH IDE dim dim				{$$ = makenode(MESH,$3,$4,NULL,NULL,0,$2);}
		;

/* REGISTER definition */
register_def:	REGISTER nextIDE			{$$ = makenode(REGISTER,$2,NULL,NULL,NULL,0,NULL);}
		;

nextIDE:	nextIDE	',' IDE					{$$ = makenode(REGISTER,$1,NULL,NULL,NULL,0,$3);}
		|IDE						{ $$ = makenode(REGISTER,NULL,NULL,NULL,NULL,0,$1);}
		;


/* OUTPUT Vector  definition*/	
out_vec_def:	OUTPUT nextVector			{$$ = makenode(OUTPUT,$2,NULL,NULL,NULL,0,NULL);}
		;

/* INPUT Vector definition*/
in_vec_def:	INPUT nextVector 				{$$ = makenode(INPUT,$2,NULL,NULL,NULL,0,NULL);}
		;

/* Single Vector */
vector:         IDE dim		 				{$$ = makenode(VECTOR,$2,NULL,NULL,NULL,0,$1);}
		|','IDE dim 					{$$ = makenode(VECTOR,$3,NULL,NULL,NULL,0,$2);}	
		;

nextVector:	nextVector ',' vector				{$$ = makenode(VECTOR,$1,$3,NULL,NULL,0,NULL);}
		| vector 					{ $$ = makenode(VECTOR,$1,NULL,NULL,NULL,0,NULL);}
		;


/* Dimention  */
dim:		'[' INTCONST ']'				{$$ = genLeaf(MESH,$2,0,"dimention declaration");}
		;

/* Algorithm Steps */
staeps_seq: 	PBEGIN nextStep singleStep END 			{$$ = makenode(STEP,$2,$3,NULL,NULL,0,NULL);}
		;

nextStep:	nextStep singleStep				{ $$ = makenode(STEP,$1,$2,NULL,NULL,0,NULL);}
		|DUMMY						{ $$ = makenode(DUMMY,NULL,NULL,NULL,NULL,0,NULL); }
		;

singleStep:	STEP  readPhase calcPhase busPhase writePhase  {$$ = makenode(STEP,$2,$3,$4,$5,0,itoa(stepNum,buf,10)); stepNum++ ;}
				;
readPhase:	'R' ':' readBlock				{$$ = $3;}
		;
calcPhase:	'C' ':'	calcBlock				{$$ = $3;}
		;
busPhase:	'B' ':' busBlock				{$$ = $3;}
		;		
writePhase:	'W' ':' writeBlock				{$$ = $3;}
		;

readBlock:	block						{$$ = makenode(PHASE,$1,NULL,NULL,NULL,0,"READ");}				
		;
calcBlock:	block						{$$ = makenode(PHASE,$1,NULL,NULL,NULL,0,"CALCULATE");}
		;
busBlock:	block						{$$ = makenode(PHASE,$1,NULL,NULL,NULL,0,"BUS");}
		;
writeBlock:	block						{$$ = makenode(PHASE,$1,NULL,NULL,NULL,0,"WRITE");}
		;
block:		LC stat_seq RC					{$$ = makenode(STATAMENT,$2,NULL,NULL,NULL,0,"statment");}
		;

stat_seq: 	stat 			                        {$$=makenode(STATEMENT,$1,NULL,NULL,NULL,0,NULL);} 
		| stat stat_seq					{$$=makenode(STATEMENT,$1,$2,NULL,NULL,0,NULL);} 
		;

stat:    	LC expr RC			                {$$ = makenode(REGISTER,$2,NULL,NULL,NULL,0,NULL); }
		;

expr:	expr ADD expr { $$ = makenode(ADD,$1,$3,NULL,NULL,0,NULL);}
		|expr MIN expr { $$ = makenode(MIN,$1,$3,NULL,NULL,0,NULL);}
		|expr MUL expr { $$ = makenode(MUL,$1,$3,NULL,NULL,0,NULL);}
		|expr DIV expr { $$ = makenode(DIV,$1,$3,NULL,NULL,0,NULL);}
		|expr MOD expr { $$ = makenode(MOD,$1,$3,NULL,NULL,0,NULL);}
		|expr LES expr { $$ = makenode(LES,$1,$3,NULL,NULL,0,NULL);}
		|expr LEQ expr { $$ = makenode(LEQ,$1,$3,NULL,NULL,0,NULL);}
		|expr EQU expr { $$ = makenode(EQU,$1,$3,NULL,NULL,0,NULL);}
		|expr NEQ expr { $$ = makenode(NEQ,$1,$3,NULL,NULL,0,NULL);}
		|expr GRE expr { $$ = makenode(GRE,$1,$3,NULL,NULL,0,NULL);}
		|expr GEQ expr { $$ = makenode(GEQ,$1,$3,NULL,NULL,0,NULL);}
		| '(' expr ')'               { $$ = $2; }
		| MIN atom %prec DUMMY    { $$ = makenode(MIN,$2,NULL,NULL,NULL,0,NULL); }
		| NOT atom                   { $$ =makenode(NOT,$2,NULL,NULL,NULL,0,NULL); }
		| atom                       { $$ = $1; }
		;

atom: INTCONST                   { $$ = genLeaf(INTCONST,$1,0,NULL); }
      | REALCONST                  { $$ = genLeaf(REALCONST,0,$1,NULL);}
      | TRUE                       { $$ = genLeaf(TRUE,0,0,NULL); }
      | FALSE                      { $$ = genLeaf(FALSE,0,0,NULL); }
      ;

%%




/* additional helper functions */
int yyerror(char* s)
{
	fprintf(stderr,"ERROR: %s in line %d at symbol",s,6, yytext);
  exit(1);
}

/*==   AST - PART constructs the tree ============================*/
NODE makenode(int op, NODE s1, NODE s2, NODE s3, NODE s4,int val,char *id)
{   int i=0;
	NODE t;
    
	t= (NODE )malloc(sizeof(struct node));
    t->val=val;
	if(op==CASE)
	  t->s1=genLeaf(INTCONST,val,0,NULL);
	else
	  t->s1 = s1;
	t->s2 = s2;
	t->s3 = s3;
	t->s4 = s4;
        if(id != NULL) 
           t->name=id; 
	else 
	  t->name="";
	 if (t->s1!=NULL)
	   i++;
     if (s2!=NULL)
	   i++;
     if (s3!=NULL)
	   i++;
	 if (s4!=NULL)
		i++;
	t->children=i;
	t->op=op;
	return(t);
}

NODE genLeaf(int op, int val, double rval,char *id)
{
	NODE t;
	t= (NODE )malloc(sizeof(struct node));
        t->val=val;
        t->rval=rval;
	t->op = op;
if(id != NULL) 
           t->name=id;  
else	       
		   t->name="";
	t->s1 = NULL;
	t->s2 = NULL;
	t->s3 = NULL;
	t->children=0;
	return(t);
}