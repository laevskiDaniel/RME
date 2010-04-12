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

% REGISTER  
% PHASE
% PROGRAM   
% BBEGIN  
% END  
% FALSE  
% TRUE  	
% DIM  
% SCAN  
% PRINT   
% OUTPUT  
% EXECUTE   
% CONNECT   
% NORTH   
% SOUTH   
% WEST   
% EAST   
% VOID   
% MESH   
% INPUT   
% VAR   
% BIN   
% PST   
% FI   
% IF   
% ELSE   
% THEN   
% NOT   
% PROCEDURE   
% IDE   
% INTCONST   
% REALCONST   
% STRING   
% ADD   
% MIN   
% MUL   
% DIV   
% MOD   
% LES   
% LEQ   
% EQU   
% NEQ   
% GRE   
% GEQ   
% AND   
% OR   
% ASSIGN   
% LC   
% RC   
% F_1UN  
% F_2UN  

%token<code> INTCONST
%token<string> IDE
%token<real> REALCONST
%token<string> STRING   

/* expresion suntax */
%%

%%

/* additional  */
int yyerror(char* s)
{
	extern int yylineno;	// defined and maintained in lex.c
	extern char *yytext;	// defined and maintained in lex.c
	fprinff(stderr,"ERROR: %s in line %d at symbol",s,yylineno, yytext);
  	
  exit(1);
}

