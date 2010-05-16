%{
#include <stdio.h>
#include <malloc.h>
#include <string.h>
#include "typedef.h"
#define yyerror(x) { printf("%s in line %d\n",x,line_number);}
NODE root;
int line_number = 1;
extern int yylex(void);
extern FILE *treefile;
NODE makenode(int op, NODE s1, NODE s2, NODE s3,int val,char *id);
NODE genLeaf(int op, int val, double rval,char *id);

%}

%union
   { int code;
     double real;
     char *string;
     NODE node;
   }
%token PROGRAM BBEGIN END DECLARE PROCEDURE LABEL INTEGER REAL
%token BOOLEAN ARRAY OF ASSIGN LC RC IF THEN ELSE FI WHILE REPEAT DO OD MULTICOND
%token READ WRITE TRUE FALSE ADD MIN MUL DIV GOTO
%token MOD LES LEQ EQU NEQ GRE GEQ AND OR
%token NOT CASE FOR FIN IDENTICAL FROM BY TO
%token<code> INTCONST
%token<string> IDE
%token<real> REALCONST
%token<string> STRING

%type<node> var assign program stat_seq loop_stat case_stat forNext multicond
%type<node> expr atom block stat nonlable_stat cond_stat case case_list

%nonassoc LES LEQ EQU NEQ GRE GEQ
%left ADD MIN OR
%left MUL DIV AND MOD
%right NOT DUMMY


%start  program

%%
program: PROGRAM IDE block            {$$=makenode(PROGRAM,$3,NULL,NULL,0,$2); root=$$;} 
       ;

block :LC stat_seq RC                   {$$=makenode(BBEGIN,$2,NULL,NULL,0,NULL);} 
       ;

stat_seq: stat                        {$$=makenode(STATEMENT,$1,NULL,NULL,0,NULL);} 
         | stat stat_seq              {$$=makenode(STATEMENT,$1,$2,NULL,0,NULL);} 
		 ;

stat:    nonlable_stat                    {$$=$1;}
         ;

nonlable_stat:  assign';'                   {$$=$1;}
              | cond_stat                   {$$=$1;}
			  | loop_stat                   {$$=$1;}
			  | case_stat                   {$$=$1;}
			  ;  

assign :  var ASSIGN expr             {$$=makenode(ASSIGN,$1,$3,NULL,0,NULL);}
       ;

cond_stat: IF expr THEN stat_seq FI     {$$=makenode(IF,$2,$4,NULL,0,NULL);}
          |IF expr THEN stat_seq ELSE stat_seq FI {$$=makenode(IF,$2,$4,$6,0,NULL);}  
		  | MULTICOND '(' expr multicond stat_seq RC {$$=makenode(MULTICOND,$3,$4,$5,0,NULL);}
          ; 
		  
multicond: ')' LC								 { $$ = makenode(STATEMENT,0,0,0,0,NULL); }
			|	';' expr multicond stat_seq ',' 	{$$=makenode(MULTICOND,$2,$3,$4,0,NULL);}   
			;
		  
forNext:  expr ';' assign ')' DO  stat_seq  OD {$$=makenode(STATEMENT,$1,$6,$3,0,NULL);}
		  ;

loop_stat: WHILE expr DO  stat_seq OD {$$=makenode(WHILE,$2,$4,NULL,0,NULL);}
		  |FOR  '(' assign ';' forNext  {$$=makenode(FOR,$3,$5,NULL,0,NULL);}
           ;
		   
case_stat :CASE expr OF LC case_list RC {$$=makenode(CASESTAT,$2,$5,NULL,0,NULL);}
          ;
		    
case_list:  case               {$$=makenode(CASELIST,$1,NULL,NULL,0,NULL);}
           |case case_list      {$$=makenode(CASELIST,$1,$2,NULL,0,NULL);}

case :  INTCONST ':' stat_seq  {$$=makenode(CASE,NULL,$3,NULL,$1,NULL);}   


var:   IDE                         { $$ = genLeaf(IDE,0,0,$1);}
     | var '[' expr ']'            { $$ = makenode('[',$1,$3,NULL,0,NULL); }
     ;


expr:   expr ADD expr           { $$ = makenode(ADD,$1,$3,NULL,0,NULL);}
      | expr MIN expr           { $$ = makenode(MIN,$1,$3,NULL,0,NULL);}
      | expr MUL expr           { $$ = makenode(MUL,$1,$3,NULL,0,NULL);}
      | expr DIV expr           { $$ = makenode(DIV,$1,$3,NULL,0,NULL);}
      | expr MOD expr           { $$ = makenode(MOD,$1,$3,NULL,0,NULL);}
      | expr LES expr           { $$ = makenode(LES,$1,$3,NULL,0,NULL);}
      | expr LEQ expr           { $$ = makenode(LEQ,$1,$3,NULL,0,NULL);}
      | expr EQU expr           { $$ = makenode(EQU,$1,$3,NULL,0,NULL);}
      | expr NEQ expr           { $$ = makenode(NEQ,$1,$3,NULL,0,NULL);}
      | expr GRE expr           { $$ = makenode(GRE,$1,$3,NULL,0,NULL);}
      | expr GEQ expr           { $$ = makenode(GEQ,$1,$3,NULL,0,NULL);}
      | expr AND expr           { $$ = makenode(AND,$1,$3,NULL,0,NULL);}
      | expr OR expr            { $$ = makenode(OR,$1,$3,NULL,0,NULL);}
      | '(' expr ')'               { $$ = $2; }
      | MIN atom %prec DUMMY    { $$ = makenode(MIN,$2,NULL,NULL,0,NULL); }
      | NOT atom                   { $$ =makenode(NOT,$2,NULL,NULL,0,NULL); }
      | atom                       { $$ = $1; }
      ;


atom:   var                        { $$ = $1; }
      | INTCONST                   { $$ = genLeaf(INTCONST,$1,0,NULL); }
      | REALCONST                  { $$ = genLeaf(REALCONST,0,$1,NULL);}
      | TRUE                       { $$ = genLeaf(TRUE,0,0,NULL); }
      | FALSE                      { $$ = genLeaf(FALSE,0,0,NULL); }
      ;

%%
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

char *print_op(int op)
{
    switch (op) {
      case PROGRAM:
	    return ("PROGRAM");
	    break; 
	   case STATEMENT:
	    return ("STATEMENT");
	    break;
	  case BBEGIN:
	   return("BEGIN");
	    break;
	  case ASSIGN:
	    return ("ASSIGN");
	    break;
      case IDE:
	    return ("IDE");
		break;
      case ADD:
	    return ("ADD");
		break;
	case MIN:
	    return ("MIN");
		break;
    case MUL:
	    return ("MUL");
		break;
	case DIV:
	    return ("DIV");
		break;
	case MOD:
	    return ("MOD");
        break;
    case AND:
	    return ("AND");
		break;
	case OR:
	    return ("OR");
		break;
	case NOT:
	    return ("NOT");
		break;
	case INTCONST:
	    return ("INTCONST");
		break; 
    case REALCONST:
	    return ("REALCONST");
		break;
	case TRUE:
	    return ("TRUE");
		break;
	case FALSE:
	    return ("FALSE");
		break;
	case IF:
	    return ("IF");
		break;
	case LES:
	    return ("LES");
		break;
    case LEQ:
	    return ("LEQ");
		break;
    case EQU:
	    return ("EQU");
		break;
	case NEQ:
	    return ("NEQ");
		break;
	case GRE:
	    return ("GRE");
		break;
	case GEQ:
	    return ("GEQ");
		break;
	case WHILE:
	    return ("WHILE");
		break;
    case CASESTAT:
	    return ("CASESTAT");
		break;
    case CASELIST:
	    return ("CASELIST");
		break;
    case CASE:
	    return ("CASE");
		break;
	case FOR:
		return ("FOR");
		break;
	case MULTICOND:
			return ("MULTICOND");
			break;
	default:
	      printf("Unknown Token\n");
	}     
}

void print_tree(NODE r, int s)
{ 
  
if(r != NULL) { 
                fprintf(treefile,"type=%s\n", print_op(r->op));
				fprintf(treefile,"children=%d\n", r->children);
				if(r->op == IDE) fprintf(treefile,"string=%s\n",r->name);
                if(r->op ==INTCONST)  fprintf(treefile,"value=%d\n", r->val); 
                if(r->op==REAL) fprintf(treefile,"value=%f\n", r->rval); 
                fprintf(treefile,"|\n");
				if(r->s1!=NULL){
                  fprintf(treefile,"| s1 of %s\n",print_op(r->op));
                  fprintf(treefile,"|\n");
	              fprintf(treefile,"--\n");
	              print_tree(r->s1,s+2);

	            } 
	  
	           
	        if(r->s2!=NULL){
               fprintf(treefile,"| s2 of %s\n",print_op(r->op));
               fprintf(treefile,"|\n");
	           fprintf(treefile,"--\n");
               print_tree(r->s2, s+2);
	
            }
 
          if(r->s3!=NULL){
               fprintf(treefile,"| s3 of %s\n",print_op(r->op));
               fprintf(treefile,"|\n");
	           fprintf(treefile,"--\n");
               print_tree(r->s3, s+2);
	
            } 
 
 }
 
 
 
 
}


