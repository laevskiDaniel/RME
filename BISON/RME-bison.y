%{
	#include "headings.h"
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

%token REGISTER  
%token PHASE
%token PROGRAM   
%token BBEGIN  
%token END  
%token FALSE  
%token TRUE  	
%token DIM  
%token SCAN  
%token PRINT   
%token OUTPUT  
%token EXECUTE   
%token CONNECT   
%token NORTH   
%token SOUTH   
%token WEST   
%token EAST   
%token VOID   
%token MESH   
%token INPUT   
%token VAR   
%token BIN   
%token PST   
%token FI   
%token IF   
%token ELSE   
%token THEN   
%token NOT   
%token PROCEDURE   
%token IDE   
%token INTCONST   
%token REALCONST   
%token STRING   
%token ADD   
%token MIN   
%token MUL   
%token DIV   
%token MOD   
%token LES   
%token LEQ   
%token EQU   
%token NEQ   
%token GRE   
%token GEQ   
%token AND   
%token OR   
%token ASSIGN   
%token LC   
%token RC   
%token F_1UN  
%token F_2UN  

%token<code> INTCONST
%token<string> IDE
%token<real> REALCONST
%token<string> STRING   

/* expresion suntax */
%%

%%

/* additional helper functions */
int yyerror(char* s)
{
	extern int yylineno;	// defined and maintained in lex.c
	extern char *yytext;	// defined and maintained in lex.c
	fprinff(stderr,"ERROR: %s in line %d at symbol",s,yylineno, yytext);
  	
  exit(1);
}

