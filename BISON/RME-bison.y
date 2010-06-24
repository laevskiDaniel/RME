%{
	#include <stdio.h>
	#include <malloc.h>
	#include <string.h>
	#include "heading.h"
	/*
	#define YYERROR_VERBOSE 
	#define YYPARSE_PARAM parm
	#define YYLEX_PARAM parm
	*/
	extern int yylineno;	// defined and maintained in lex.c
	extern char *yytext;	// defined and maintained in lex.c
	extern FILE* dbglog;
	int stepNum = 0;
	int line_number = 1;
	char buf[12];
	NODE root;
	NODE makenode(int op, NODE s1, NODE s2, NODE s3, NODE s4,int val,char *id);
	NODE genLeaf(int op, int val, double rval,char *id);
	int yyerror(char *s);
	int printError(char *s);
	int yylex(void);
%}

%union
   { int code;
     double real;
     char *string;
     NODE node;
   }
 /* token definitions */ 

%token PROGRAM PBEGIN END STATEMENT
%token VECTOR OUTPUT INPUT   
%token EXECUTE CONNECT SCAN PRINTV
%token PHASE   
%token REGISTER VAR MESH DIM VOID 
%token IF ELSE THEN
%token ADD MIN MUL DIV MOD LES LEQ EQU NEQ GRE GEQ   
%token AND OR NOT FALSE TRUE  	
%token ASSIGN 
%token LC RC 
%token STEP CASE
/*TODO: procedure??????????????? */
%token PROCEDURE F_1UN F_2UN F_BIN F_PST   

%token<code> INTCONST
%token<string> IDE 
%token<real> REALCONST
%token<string> STRING CLASS COMMENT
%token<string> SOUTH WEST EAST N0RTH

%type<node> program
%type<node> expr atom asingn_stat
%type<node> var_seq nextVar staeps_seq mesh_def register_def out_vec_def in_vec_def dim block singleVar class if_stm_end
%type<node> readBlock calcBlock busBlock writeBlock stat_seq stat singleStep nextStep phase	if_stat connect conect_stat ide
%type<node> readPhase calcPhase busPhase writePhase nextIDE nextVector vector scan_stat print_stat exe_stat pos pos3/* expresion suntax */
%type<node> functions pst bin f_1un f_2un

%nonassoc LES LEQ EQU NEQ GRE GEQ DIM3 FI
%left ADD MIN OR MUL DIV AND MOD
%right NOT DUMMY

%start program

%%


program:	PROGRAM IDE var_seq staeps_seq END PROGRAM	{$$ = makenode(PROGRAM,$3,$4,NULL,NULL,0,$2); root=$$;}
		|	error	IDE 							 	{printError("Unundentify token");}
		|	PROGRAM error var_seq 						{printError("Illigal program name");}
		;
/*  */
var_seq:	VAR nextVar 					{ $$ = $2;}/*{$$ = makenode(VAR,$2,NULL,NULL,NULL,0,"var_seq");}*/
		;

nextVar:	 nextVar  singleVar ';'     { $$ = makenode(VAR,$1,$2,NULL,NULL,0,NULL);}
			|singleVar ';'				{$$ = $1;}
		;

singleVar:	 mesh_def 					{$$ = $1;}
			|register_def 				{$$ = $1;}
			|out_vec_def				{$$ = $1;}
			|in_vec_def 				{$$ = $1;}
		;		
		
		
/* mesh definition can be only one */
mesh_def:	MESH IDE dim dim				{$$ = makenode(MESH,$3,$4,NULL,NULL,0,$2);}
		;

/* REGISTER definition */
register_def:	REGISTER nextIDE			{$$ = makenode(REGISTER,$2,NULL,NULL,NULL,0,NULL);}
		;

nextIDE:	nextIDE	',' IDE					{ $$ = makenode(REGISTER,$1,NULL,NULL,NULL,0,$3);}
		|IDE								{ $$ = genLeaf(REGISTER,NULL,0,$1);}
		;


/* OUTPUT Vector  definition*/	
out_vec_def:	OUTPUT nextVector			{ $$ = makenode(OUTPUT,$2,NULL,NULL,NULL,0,NULL);}
		;

/* INPUT Vector definition*/
in_vec_def:	INPUT nextVector 				{ $$ = makenode(INPUT,$2,NULL,NULL,NULL,0,NULL);}
		;

/* Single Vector */
vector:         IDE dim		 				{ $$ = makenode(VECTOR,$2,NULL,NULL,NULL,0,$1);}
		|','IDE dim 						{ $$ = makenode(VECTOR,$3,NULL,NULL,NULL,0,$2);}	
		;

nextVector:	nextVector ',' vector			{$$ = makenode(VECTOR,$1,$3,NULL,NULL,0,NULL);}
		| vector 							{ $$=$1;}/*{ $$ = makenode(VECTOR,$1,NULL,NULL,NULL,0,NULL);}*/
		;


/* Dimention  */
dim:		'[' INTCONST ']'				{$$ = genLeaf(DIM,$2,0,"dimention declaration");}
		;

/* Algorithm Steps */
staeps_seq: 	 nextStep 						{ $$=$1;} /*{$$ = makenode(STEP,$1,NULL,NULL,NULL,0,NULL);}*/
		;

nextStep:	STEP singleStep nextStep /* nextStep */				{ $$ = makenode(STEP,$2,$3,NULL,NULL,0,NULL);}
		| error '\n'											{printError("undefined token","blabla");}
		|STEP singleStep												{ $$ = makenode(STEP,$2,NULL,NULL,NULL,0,NULL);}
		/*|DUMMY						{ $$ = makenode(DUMMY,NULL,NULL,NULL,NULL,0,NULL); }*/
		;

singleStep:	 readPhase calcPhase busPhase writePhase  {$$ = makenode(STEP,$1,$2,$3,$4,stepNum,itoa(stepNum,buf,10)); stepNum++ ;}
				;
readPhase:	PHASE readBlock				{ $$=$2;} /*{$$ = makenode(PHASE,$2,NULL,NULL,NULL,0,"read");}*/
			| PHASE						{ $$ = genLeaf(DUMMY,0,0,"EMPTY READ PHASE");}
		;
calcPhase:	PHASE calcBlock				{ $$=$2;} /*{$$ = makenode(PHASE,$2,NULL,NULL,NULL,0,"calc");}*/
			| PHASE						{ $$ = genLeaf(DUMMY,0,0,"EMPTY CALCULATE PHASE");}
		;
busPhase:	PHASE busBlock				{ $$=$2;} /*{$$ = makenode(PHASE,$2,NULL,NULL,NULL,0,"bus");}*/
			| PHASE						{ $$ = genLeaf(DUMMY,0,0,"EMPTY BUS PHASE");}
		;		
writePhase:	PHASE writeBlock			{ $$=$2;} /*{$$ = makenode(PHASE,$2,NULL,NULL,NULL,0,"write");}*/
			| PHASE						{ $$ = genLeaf(DUMMY,0,0,"EMPTY WRITE PHASE");}
		;

readBlock:	block						{$$ = makenode(PHASE,$1,NULL,NULL,NULL,0,"READ");}				
		;
calcBlock:	block						{$$ = makenode(PHASE,$1,NULL,NULL,NULL,0,"CALCULATE");}
		;
busBlock:	block						{$$ = makenode(PHASE,$1,NULL,NULL,NULL,0,"BUS");}
		;
writeBlock:	block						{$$ = makenode(PHASE,$1,NULL,NULL,NULL,0,"WRITE");}
		;
		
		
block:	stat_seq						{$$ = $1;} /*{$$ = makenode(0,$1,NULL,NULL,NULL,0,NULL);}*/
	;
scan_stat:  SCAN '(' ide ',' pos3 ',' ide ',' phase ')' ';' {$$ = makenode(SCAN,$3,$5,$7,$9,0,NULL);}
		;
		
print_stat: PRINTV '(' ide ',' pos3 ',' ide ',' phase ')' ';' {$$ = makenode(PRINTV,$3,$5,$7,$9,0,NULL);}
		;
/*TODO:  on execute IDE or vector*/
exe_stat:	EXECUTE '(' ide ',' pos3 ',' atom ',' phase ')' ';' {$$ = makenode(EXECUTE,$3,$5,$7,$9,0,NULL);}
			/*|EXECUTE '(' ide ',' pos3 ',' INTCONST ',' phase ')' ';' {$$ = makenode(EXECUTE,$3,$5,$7,$9,0,NULL);}*/

conect_stat:	CONNECT '(' connect ')' ';'					{ $$ = makenode(CONNECT,$3,NULL,NULL,NULL,0,"Connect");}
				|CONNECT '(' connect  ',' connect ')' ';'	{$$ = makenode(CONNECT,$3,$5,NULL,NULL,0,"Connect");}
		;
functions:		pst										{$$=$1;}
				|bin										{$$=$1;}
				|f_1un									{$$=$1;}
				|f_2un									{$$=$1;}
				;
		
pst:			F_PST '('	ide ')' ';'						{ $$ = makenode(F_PST,$3,NULL,NULL,NULL,0,NULL);}
		;
f_1un:			F_1UN '(' ide ')' ';'					{ $$ = makenode(F_1UN,$3,NULL,NULL,NULL,0,NULL);}
		;
f_2un:			F_2UN '(' ide ')' ';'					{ $$ = makenode(F_2UN,$3,NULL,NULL,NULL,0,NULL);}
		;
bin:			F_BIN '(' ide ')' ';'						{ $$ = makenode(F_BIN,$3,NULL,NULL,NULL,0,NULL);}
		;


pos3: 	pos pos pos 						{$$ = makenode(DIM,$1,$2,$3,NULL,0,NULL);}
		|pos pos 							{$$ = makenode(DIM,$1,$2,NULL,NULL,0,NULL);}
	;

pos:	'[' atom ',' atom ']' 		{$$ = makenode(DIM,$2,$4,NULL,NULL,0,NULL);}
		|'['']' 							{$$ = genLeaf(DIM,0,0,NULL);}
		;

phase: 	SOUTH 								{$$ = genLeaf( SOUTH,0,0,$1);}
		|WEST 								{$$ = genLeaf( WEST,0,0,$1);}
		|EAST 								{$$ = genLeaf( EAST,0,0,$1);}
		|N0RTH								{$$ = genLeaf( N0RTH,0,0,$1);}
		;
connect: 	phase MIN phase							{$$ = makenode(CONNECT,$1,$3,NULL,NULL,0,NULL);}
			|phase MIN  phase MIN phase				{$$ = makenode(CONNECT,$1,$3,$5,NULL,0,NULL);}
			|phase MIN phase MIN phase MIN phase	{$$ = makenode(CONNECT,$1,$3,$5,$7,0,NULL);}
		;

asingn_stat: phase ASSIGN atom ';'			{ $$ = makenode(ASSIGN, $1,$3,NULL,NULL,0,"phase"); }
			| class ASSIGN atom ';'			{ $$ = makenode(ASSIGN, $1,$3,NULL,NULL,0,"class"); }
			| ide ASSIGN atom ';'			{ $$ = makenode(ASSIGN, $1,$3,NULL,NULL,0,"ide"); }
		;
		
class:      ide '.' ide								{$$ = makenode(CLASS,$1,$3,NULL,NULL,0,"ide");}
			|ide '.' phase							{$$ = makenode(CLASS,$1,$3,NULL,NULL,0,"phase");} 
		;
stat_seq: 	  stat_seq stat		        {$$=makenode(STATEMENT,$1,$2,NULL,NULL,0,"stat stat_seq");} 
			|stat						{$$=makenode(STATEMENT,$1,NULL,NULL,NULL,0,"stat");}
			;
		

stat:    scan_stat 					{$$=$1;} /*{$$ = makenode(STATEMENT,$1,NULL,NULL,NULL,0,"Scan");}*/
			|print_stat					{$$=$1;} /*{$$ = makenode(STATEMENT,$1,NULL,NULL,NULL,0,"statment");}*/
			|exe_stat					{$$=$1;} /*{$$ = makenode(STATEMENT,$1,NULL,NULL,NULL,0,"statment");}*/
			|if_stat					{$$ = $1;}
			|conect_stat				{$$ = $1;}
			|asingn_stat				{$$ = $1;}
			|functions					{$$ = $1;}
		;
/*TODO: complex if expression*/
if_stat:		IF 	expr THEN stat_seq if_stm_end			{$$ = makenode(IF,$2,$4,$5,NULL,0,NULL);}
			| IF expr THEN stat_seq ELSE stat_seq if_stm_end {$$ = makenode(ELSE,$2,$4,$6,$7,0,NULL);}
		;
if_stm_end:	FI												{$$ = genLeaf(FI,0,0,NULL);}

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
		|expr AND AND expr	{ $$ = makenode(AND,$1,$4,NULL,NULL,0,NULL);}
		|expr OR OR expr 	{ $$ = makenode(OR ,$1,$4,NULL,NULL,0,NULL);}
		| '(' expr ')'               { $$ = $2; }
		| MIN atom %prec DUMMY    { $$ = makenode(MIN,$2,NULL,NULL,NULL,0,NULL); }
		| NOT atom                   { $$ =makenode(NOT,$2,NULL,NULL,NULL,0,NULL); }
		| atom                       { $$ = $1; }
		;

atom: INTCONST                   { $$ = genLeaf(INTCONST,$1,0,NULL); }
      | REALCONST                  { $$ = genLeaf(REALCONST,0,$1,NULL);}
      | TRUE                       { $$ = genLeaf(TRUE,0,0,NULL); }
      | FALSE                      { $$ = genLeaf(FALSE,0,0,NULL); }
	  | phase						{$$ = $1;}
	  | class						{$$ = $1;}
	  | ide							{$$ = $1;}
      ;
ide: 	IDE						{$$ = genLeaf(IDE,0,0,$1);}

%%




/* additional helper functions */
int yyerror(char* errorStr, char* hint)
{	
//		fprintf(dbglog,"ERROR: %s in line %d at symbol %s\n",s,6, yytext);
		fprintf(dbglog,"%s (%d) Error: %s %s %s. \n",__FILE__,line_number,errorStr, yytext,hint);
		return 1;
}
int printError(char* s)
{	
//		fprintf(dbglog,"ERROR: %s in line %d at symbol %s",s,6, yytext);
		fprintf(dbglog,"%s (%d) Error: %s %s. \n",__FILE__,line_number,s, yytext);
		return 1;
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
	t = (NODE )malloc(sizeof(struct node));
    t->val = val;
    t->rval = rval;
	t->op = op;
	if(id != NULL) 
        t->name = id;  
else	       
		   t->name="";
	t->s1 = NULL;
	t->s2 = NULL;
	t->s3 = NULL;
	t->s4 = NULL;
	t->children=0;
	return(t);
}