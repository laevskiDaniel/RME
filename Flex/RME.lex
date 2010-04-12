%option yylineno
%{ 
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "C:\RME\RiconfigurableMesh\RiconfigurableMesh\debug.h"
extern int line_number; 

int count_newline(char*);

yywrap() {return 1; }

%}


DIGIT	[0-9]
LETTER	[a-zA-Z]
IDE		{LETTER}({LETTER}|{DIGIT})*
INT		{DIGIT}+
SCALE	E("+"|"-")?{INT}
REAL	{INT}?"."{INT}{SCALE}?
STRING	\"(\\.|[^\\"])*\"
COMMENT	\(\*[^\*]*\*+([^\*\)][^\*]*\*+)*\)
DIM 	\[{INT}\]
SIGN	(":"|";"|"("|")"|"."|","|"["|"]")
PHASE	("R"|"C"|"B"|"W")

%%
"Register"		{ return(REGISTER);	}
{PHASE}			{ return(PHASE);	}
"Program"			{ return(PROGRAM);	}
"Begin"			{ return(BBEGIN);	} 
"End"				{ return(END);		}
"FALSE"			{ return(FALSE);	}
"TRUE"			{ return(TRUE);		}
{DIM}				{ return(DIM);		}
"Scan"			{ return(SCAN);		}
"Print"			{ return(PRINT);	}
"Execute"			{ return(EXECUTE);	}
"Connect"			{ return(CONNECT);	}
"N0RTH"			{ return(N0RTH);	}
"SOUTH"			{ return(SOUTH);	}
"WEST"			{ return(WEST);		}
"EAST"			{ return(EAST);		}
"VOID"			{ return(VOID);		}
"Mesh"			{ return(MESH);		}
"Input"			{ return(INPUT);	}
"Output"			{ return(OUTPUT);	}
"var"				{ return(VAR);		}
"1UN"				{ return(F_1UN);		}
"2UN"				{ return(F_2UN);		}
"BIN"				{ return(BIN); 		}
"PST"				{ return(PST);		}
"fi"            	{ return(FI);		}
"if"            	{ return(IF);		}
"else"	        { return(ELSE); 	}
"then"			{ return(THEN);		}
"NOT"           { return(NOT); }
"PROCEDURE"     { return(PROCEDURE); }

{IDE}		    { yylval = (char*) malloc(strlen(yytext)+1);
						strcpy(yylval,yytext); return(IDE); }
{INT}        { yylval = atoi(yytext); return(INTCONST); }
{REAL}     { yylval = atof(yytext); return(REALCONST); }
{STRING}   { yylval = (char*) malloc(strlen(yytext)+1);
                strcpy(yylval,yytext); return(STRING); }
{COMMENT}   { line_number += count_newline(yytext); }

"+"           { return(ADD); }
"-"           { return(MIN); }
"*"           { return(MUL); }
"/"           { return(DIV); }
"%"           { return(MOD); }
"<"           { return(LES); }
"<="          { return(LEQ); }
"=="           { return(EQU); }
"/="           { return(NEQ); }
">"           { return(GRE); }
">="          { return(GEQ); }
"&"           { return(AND); }
"|"           { return(OR); }
"="          { return(ASSIGN); }
"{"         { return(LC); } 
"}"         { return(RC); } 
{SIGN}     { return(yytext[0]); }
"\n"          { line_number++; }
[\t\f\ ]+
.             { fprintf(stderr,"unexpected char '%c'!\n",yytext[0]); exit(-1); }
%%
int count_newline(char *text)

{ unsigned int i;
  int counter;

  counter = 0;
  for (i=0;i<strlen(text);i++)
      { if (text[i] == '\n')
	   counter++;
      }
  return(counter);
}

