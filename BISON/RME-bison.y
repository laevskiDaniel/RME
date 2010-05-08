%{
	#include "headings.h"
	extern int yylineno;	// defined and maintained in lex.c
	extern char *yytext;	// defined and maintained in lex.c
	NODE root;
	NODE makenode(int op, NODE s1, NODE s2, NODE s3,int val,char *id);
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

%token PROGRAM BBEGIN END  
%token OUTPUT INPUT   
%token EXECUTE CONNECT SCAN PRINT
%token PHASE NORTH SOUTH WEST EAST   
%token REGISTER VAR MESH DIM VOID
%token IF FI ELSE THEN
%token ADD MIN MUL DIV MOD LES LEQ EQU NEQ GRE GEQ   
%token AND OR NOT FALSE TRUE  	
%token ASSIGN   
%token LC RC 
%token STEP  
/*TODO: procedure??????????????? */
%token PROCEDURE F_1UN F_2UN BIN PST   

%token<code> INTCONST
%token<string> IDE
%token<real> REALCONST
%token<string> STRING   


%type<node> program
%type<node> var_seq nextVar staeps_seq mesh_def register_def out_vec_def in_vec_def dim block 
%type<node> expr atom
%type<node> readBlock calcBlock busBlock writeBlock				

/* expresion suntax */

%nonassoc LES LEQ EQU NEQ GRE GEQ
%left ADD MIN OR MUL DIV AND MOD
%right NOT DUMMY

%start  program

%%


program:	PROGRAM var_seq staeps_seq				{$$ = makenode(PROGRAM,$2,$3,NULL,0,"var declaration"); root=$$;}
			;
var_seq:	VAR nextVar								{$$ = makenode(VAR,$2,NULL,NULL,0,NULL);}
			;
			
nextVar:	 mesh_def								{$$ = makenode(MESH,$1,NULL,NULL,0,NULL);}
			|register_def							{$$ = makenode(REGISTER,$1,NULL,NULL,0,NULL);}
			|out_vec_def							{$$ = makenode(OUTPUT,$1,NULL,NULL,0,NULL);}
			|in_vec_def								{$$ = makenode(INPUT,$1,NULL,NULL,0,NULL);}
			;
/*TODO: maby seperate by newline*/
mesh_def:		MESH IDE dim dim					{}
				;
register_def:	REGISTER nextIDE IDE 				{}
				;
nextIDE:		IDE ',' nextIDE						{}
				;
out_vec_def:	OUTPUT IDE dim						{}
				;
in_vec_def:		INPUT IDE dim						{}
				;
dim:			'[' INTCONST ']'					{$$ = getLeaf(MESH,$2,0,"dimention declaration");}
				;
staeps_seq: 	STEP singleStep							{}
				;
singleStep:		readPhase calcPhase busPhase writePhase {}
				;
readPhase:		'R' ':' readBlock							{}
				;
calcPhase:		'C' ':'	calcBlock							{}
				;
busPhase:		'B' ':' busBlock							{}
				;
writePhase:		'W' ':' writeBlock							{}
				;

readBlock:		block									{}				
				;
calcBlock:		block									{}				
				;
busBlock:		block									{}				
				;
writeBlock:		block									{}				
				;
block:			DUMMY									{}
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

atom: INTCONST                   { $$ = genLeaf(INTCONST,$1,0,NULL); }
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

/*==   AST - PART constructs the tree ============================*/
NODE makenode(int op, NODE s1, NODE s2, NODE s3,int val,char *id)
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