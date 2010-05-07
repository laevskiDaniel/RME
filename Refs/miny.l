%{ 
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "typedef.h"
#include "miny_tab.h"  

extern int line_number; 

int count_newline(char*);

yywrap() {return 1; }

%}


DIGIT    [0-9]
LETTER   [a-zA-Z]
IDE      {LETTER}({LETTER}|{DIGIT})*
INT      {DIGIT}+
SCALE    E("+"|"-")?{INT}
REAL     {INT}?"."{INT}{SCALE}?
STRING   \"(\\.|[^\\"])*\"
COMMENT  \(\*[^\*]*\*+([^\*\)][^\*]*\*+)*\)
SIGN     (":"|";"|"("|")"|"."|","|"["|"]")


%%

ARRAY         { return(ARRAY); }  
BEGIN         { return(BBEGIN); } 
BOOLEAN       { return(BOOLEAN); }
DECLARE       { return(DECLARE); }
FOR            { return(FOR); }
FROM            { return(FROM); }
BY            { return(BY); }
TO            { return(TO); }
FIN            { return(FIN); }
IDENTICAL            { return(IDENTICAL); }
ELSE          { return(ELSE); }
END           { return(END); }
FALSE         { return(FALSE); }
GOTO          { return(GOTO); }
IF            { return(IF); }
MULTICOND     { return (MULTICOND);}
FI            { return(FI); }
DO            { return(DO); }
OD            { return(OD); }
CASE          { return(CASE); }
FIXED       { return(INTEGER); }
LABEL         { return(LABEL); }
NOT           { return(NOT); }
OF            { return(OF); }
PROCEDURE     { return(PROCEDURE); }
PROGRAM    { return(PROGRAM); }
READ          { return(READ); }
FLOAT          { return(REAL); }
REPEAT        { return(REPEAT); }
THEN          { return(THEN); }
TRUE          { return(TRUE); }
WHILE         { return(WHILE); }
WRITE         { return(WRITE); }
{IDE}   { yylval.string = (char*) malloc(strlen(yytext)+1);
                strcpy(yylval.string,yytext); return(IDE); }
{INT}        { yylval.code = atoi(yytext); return(INTCONST); }
{REAL}     { yylval.real = atof(yytext); return(REALCONST); }
{STRING}   { yylval.string = (char*) malloc(strlen(yytext)+1);
                strcpy(yylval.string,yytext); return(STRING); }
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

