%{ 
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "c:\RME\BISON\heading.h"
#include "C:\RME\BISON\rme-bison_tab.h"
#define RETURN(X)	fprintf(log,"Line:%d)  %s", line_number,yytext);\
					return (X);
					
extern int line_number; 
extern FILE *lexdbg;
int count_newline(char*);
void myPrintToken();

yywrap() {return 1;}

%}


DIGIT	[0-9]
PHASE	("R:"|"C:"|"B:"|"W:")
LETTER	[a-zA-Z]
IDE		{LETTER}({LETTER}|{DIGIT})*
INT		{DIGIT}+
SCALE	E("+"|"-")?{INT}
REAL	{INT}?"."{INT}{SCALE}?
STRING	\"(\\.|[^\\"])*\"
COMMENT	\(\*[^\*]*\*+([^\*\)][^\*]*\*+)*\)

SIGN	(";"|"("|")"|"."|","|"["|"]")

%%
"Register"		{ myPrintToken(); return(REGISTER);	}
{PHASE}			{ myPrintToken(); return(PHASE);	}
"Program"		{ myPrintToken(); return(PROGRAM);	}
"Begin"			{ myPrintToken(); return(PBEGIN);	} 
"End"			{ myPrintToken(); return(END);		}
"FALSE"			{ myPrintToken(); return(FALSE);	}
"TRUE"			{ myPrintToken(); return(TRUE);		}
"Step"			{ myPrintToken(); return(STEP);		}
"Scan"			{ myPrintToken(); return(SCAN);		}
"Print"			{ myPrintToken(); return(PRINTV);	}
"Execute"		{ myPrintToken(); return(EXECUTE);	}
"Connect"		{ myPrintToken(); return(CONNECT);	}
"NORTH"			{ myPrintToken(); 
					yylval.string = (char*) malloc(strlen(yytext)+1);
					strcpy(yylval.string,yytext); return(N0RTH);	}
"SOUTH"			{ myPrintToken(); 
					yylval.string = (char*) malloc(strlen(yytext)+1);
					strcpy(yylval.string,yytext); return(SOUTH);	}
"WEST"			{ myPrintToken(); 
					yylval.string = (char*) malloc(strlen(yytext)+1);
					strcpy(yylval.string,yytext); return(WEST);		}
"EAST"			{ myPrintToken();
					yylval.string = (char*) malloc(strlen(yytext)+1);
					strcpy(yylval.string,yytext); return(EAST);		}
"VOID"			{ myPrintToken(); return(VOID);		}
"Mesh"			{ myPrintToken(); return(MESH);		}
"Input"			{ myPrintToken(); return(INPUT);	}
"Output"		{ myPrintToken(); return(OUTPUT);	}
"var"			{ myPrintToken(); return(VAR);		}
"1UN"			{ myPrintToken(); return(F_1UN);	}
"2UN"			{ myPrintToken(); return(F_2UN);	}
"BIN"			{ myPrintToken();return(F_BIN); 	}
"PST"			{ myPrintToken();return(F_PST);	}
"fi"            { myPrintToken();return(FI);		}
"if"            { myPrintToken();return(IF);		}
"else"	        { myPrintToken();return(ELSE); 	}
"then"			{ myPrintToken();return(THEN);		}
"NOT"           { myPrintToken();return(NOT); 		}
"PROCEDURE"     { myPrintToken();return(PROCEDURE); }
{IDE}		    { myPrintToken();
					yylval.string = (char*) malloc(strlen(yytext)+1);
					strcpy(yylval.string,yytext); return(IDE); }
{INT}        	{ myPrintToken();
					yylval.code = atoi(yytext); return(INTCONST); }
{REAL}     		{ myPrintToken();
					yylval.real = atof(yytext); return(REALCONST); }
{STRING}   		{ myPrintToken();
					yylval.string = (char*) malloc(strlen(yytext)+1);
					strcpy(yylval.string,yytext); return(STRING); }
{COMMENT}   	{ line_number += count_newline(yytext);
					return(COMMENT);}

"+"           	{ myPrintToken(); return(ADD); }
"-"           	{ myPrintToken(); return(MIN); }
"*"           	{ myPrintToken(); return(MUL); }
"/"           	{ myPrintToken(); return(DIV); }
"%"           	{ myPrintToken(); return(MOD); }
"<"           	{ myPrintToken(); return(LES); }
"<="          	{ myPrintToken(); return(LEQ); }
"=="           	{ myPrintToken(); return(EQU); }
"/="           	{ myPrintToken(); return(NEQ); }
">"           	{ myPrintToken(); return(GRE); }
">="          	{ myPrintToken(); return(GEQ); }
"&"           	{ myPrintToken(); return(AND); }
"|"           	{ myPrintToken(); return(OR); }
"="          	{ myPrintToken(); return(ASSIGN); }
"{"         	{ myPrintToken(); return(LC); } 
"}"         	{  myPrintToken();return(RC); } 
{SIGN}     		{ myPrintToken();return(yytext[0]); }
"\n"        	{  myPrintToken();line_number++; }
[\t\f\ ]+
.             { fprintf(stderr,"unexpected char '%c'!\n",yytext[0]); exit(-1); }
%%
int count_newline(char *text)
/*DIM 	\[{INT}\]*/
/*{DIM}			{ myPrintToken(); return(DIM);		}*/
{ unsigned int i;
  int counter;

  counter = 0;
  for (i=0;i<strlen(text);i++)
      { if (text[i] == '\n')
	   counter++;
      }
  return(counter);
}
void myPrintToken()
{
		if (yytext[0] == '\n')
			fprintf(lexdbg,"%s",(yytext)?(yytext):(""));
		else
			fprintf(lexdbg," '%s' ",(yytext)?(yytext):(""));

}
