
/*  A Bison parser, made from rme-bison.y with Bison version GNU Bison version 1.24
  */

#define YYBISON 1  /* Identify Bison output.  */

#define	PROGRAM	258
#define	BBEGIN	259
#define	END	260
#define	OUTPUT	261
#define	INPUT	262
#define	EXECUTE	263
#define	CONNECT	264
#define	SCAN	265
#define	PRINT	266
#define	PHASE	267
#define	NORTH	268
#define	SOUTH	269
#define	WEST	270
#define	EAST	271
#define	REGISTER	272
#define	VAR	273
#define	MESH	274
#define	DIM	275
#define	VOID	276
#define	IF	277
#define	FI	278
#define	ELSE	279
#define	THEN	280
#define	ADD	281
#define	MIN	282
#define	MUL	283
#define	DIV	284
#define	MOD	285
#define	LES	286
#define	LEQ	287
#define	EQU	288
#define	NEQ	289
#define	GRE	290
#define	GEQ	291
#define	AND	292
#define	OR	293
#define	NOT	294
#define	FALSE	295
#define	TRUE	296
#define	ASSIGN	297
#define	LC	298
#define	RC	299
#define	STEP	300
#define	PROCEDURE	301
#define	F_1UN	302
#define	F_2UN	303
#define	BIN	304
#define	PST	305
#define	INTCONST	306
#define	IDE	307
#define	REALCONST	308
#define	STRING	309
#define	DUMMY	310

#line 1 "rme-bison.y"

	#include "headings.h"
	extern int yylineno;	// defined and maintained in lex.c
	extern char *yytext;	// defined and maintained in lex.c
	NODE root;
	NODE makenode(int op, NODE s1, NODE s2, NODE s3,int val,char *id);
	NODE genLeaf(int op, int val, double rval,char *id);
	int yyerror(char *s);
	int yylex(void);

#line 12 "rme-bison.y"
typedef union
   { int code;
     double real;
     char *string;
     NODE node;
   } YYSTYPE;

#ifndef YYLTYPE
typedef
  struct yyltype
    {
      int timestamp;
      int first_line;
      int first_column;
      int last_line;
      int last_column;
      char *text;
   }
  yyltype;

#define YYLTYPE yyltype
#endif

#include <stdio.h>

#ifndef __cplusplus
#ifndef __STDC__
#define const
#endif
#endif



#define	YYFINAL		47
#define	YYFLAG		-32768
#define	YYNTBASE	66

#define YYTRANSLATE(x) ((unsigned)(x) <= 310 ? yytranslate[x] : 84)

static const char yytranslate[] = {     0,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,    64,
    65,     2,     2,    56,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,    60,     2,     2,
     2,     2,     2,     2,     2,    62,    61,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,    59,     2,     2,     2,     2,    63,     2,     2,     2,
    57,     2,    58,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     1,     2,     3,     4,     5,
     6,     7,     8,     9,    10,    11,    12,    13,    14,    15,
    16,    17,    18,    19,    20,    21,    22,    23,    24,    25,
    26,    27,    28,    29,    30,    31,    32,    33,    34,    35,
    36,    37,    38,    39,    40,    41,    42,    43,    44,    45,
    46,    47,    48,    49,    50,    51,    52,    53,    54,    55
};

#if YYDEBUG != 0
static const short yyprhs[] = {     0,
     0,     4,     7,     9,    11,    13,    15,    20,    24,    28,
    32,    36,    40,    43,    48,    52,    56,    60,    64,    66,
    68,    70,    72,    74,    78,    82,    86,    90,    94,    98,
   102,   106,   110,   114,   118,   122,   125,   128,   130,   132,
   134,   136
};

static const short yyrhs[] = {     3,
    67,    73,     0,    18,    68,     0,    69,     0,     0,     0,
    70,     0,    71,     0,    19,    52,    72,    72,     0,    17,
     0,    52,     0,    52,    56,     0,     0,     6,    52,    72,
     0,     7,    52,    72,     0,    57,    51,    58,     0,    45,
    74,     0,    75,    76,    77,    78,     0,    59,    60,    79,
     0,    61,    60,    80,     0,    62,    60,    81,     0,    63,
    60,    82,     0,    83,     0,    83,     0,    83,     0,    83,
     0,    55,     0,     0,    26,     0,     0,     0,    27,     0,
     0,     0,    28,     0,     0,     0,    29,     0,     0,     0,
    30,     0,     0,     0,    31,     0,     0,     0,    32,     0,
     0,     0,    33,     0,     0,     0,    34,     0,     0,     0,
    35,     0,     0,     0,    36,     0,     0,    64,     0,    65,
     0,    27,     0,     0,    39,     0,     0,     0,     0,    51,
     0,    53,     0,    41,     0,    40,     0
};

#endif

#if YYDEBUG != 0
static const short yyrline[] = { 0,
    56,    58,    61,    62,    63,    64,    67,    69,    71,    73,
    75,    77,    79,    81,    83,    85,    87,    89,    92,    94,
    96,    98,   100,   102,   103,   104,   105,   106,   107,   108,
   109,   110,   111,   112,   113,   114,   115,   116,   119,   120,
   121,   122
};

static const char * const yytname[] = {   "$","error","$undefined.","PROGRAM",
"BBEGIN","END","OUTPUT","INPUT","EXECUTE","CONNECT","SCAN","PRINT","PHASE","NORTH",
"SOUTH","WEST","EAST","REGISTER","VAR","MESH","DIM","VOID","IF","FI","ELSE",
"THEN","ADD","MIN","MUL","DIV","MOD","LES","LEQ","EQU","NEQ","GRE","GEQ","AND",
"OR","NOT","FALSE","TRUE","ASSIGN","LC","RC","STEP","PROCEDURE","F_1UN","F_2UN",
"BIN","PST","INTCONST","IDE","REALCONST","STRING","DUMMY","','","'['","']'",
"'R'","':'","'C'","'B'","'W'","'('","')'","program","var_seq","nextVar","mesh_def",
"out_vec_def","in_vec_def","dim","staeps_seq","singleStep","readPhase","calcPhase",
"busPhase","writePhase","readBlock","calcBlock","busBlock","writeBlock","block",
"writeBlock"
};
#endif

static const short yyr1[] = {     0,
    66,    67,    68,    -1,    68,    68,    69,    -1,    -1,    70,
    71,    72,    73,    74,    75,    76,    77,    78,    79,    80,
    81,    82,    83,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
    -1,    -1
};

static const short yyr2[] = {     0,
     3,     2,     1,     1,     1,     1,     4,     3,     3,     3,
     3,     3,     2,     4,     3,     3,     3,     3,     1,     1,
     1,     1,     1,     3,     3,     3,     3,     3,     3,     3,
     3,     3,     3,     3,     3,     2,     2,     1,     1,     1,
     1,     1
};

static const short yydefact[] = {     0,
     0,     0,     0,     0,     0,     0,     2,     3,     5,     6,
     0,     1,     0,     0,     0,     0,    13,     0,     0,    10,
    11,     0,     0,     0,     0,     0,     7,    23,    15,    19,
     0,     0,     0,    12,    16,    20,     0,     0,    14,    17,
    21,     0,    18,    22,     0,     0,     0
};

static const short yydefgoto[] = {    45,
     3,     7,     8,     9,    10,    20,    12,    17,    18,    25,
    33,    39,    29,    35,    40,    43,    30
};

static const short yypact[] = {    -1,
   -12,    -6,   -38,   -44,   -42,   -41,-32768,-32768,-32768,-32768,
   -43,-32768,   -40,   -40,   -40,   -45,-32768,   -39,   -33,-32768,
-32768,   -40,   -36,   -37,   -35,   -34,-32768,-32768,-32768,-32768,
   -36,   -32,   -31,-32768,-32768,-32768,   -36,   -30,-32768,-32768,
-32768,   -36,-32768,-32768,    20,    21,-32768
};

static const short yypgoto[] = {-32768,
-32768,-32768,-32768,-32768,-32768,   -10,-32768,-32768,-32768,-32768,
-32768,-32768,-32768,-32768,-32768,-32768,   -28
};


#define	YYLAST		32


static const short yytable[] = {     4,
     5,     1,    36,    21,    22,     2,    11,    13,    41,    14,
    15,    27,     6,    44,    23,    16,    19,    26,    28,    46,
    47,    24,    31,    34,     0,     0,    32,    37,     0,    42,
     0,    38
};

static const short yycheck[] = {     6,
     7,     3,    31,    14,    15,    18,    45,    52,    37,    52,
    52,    22,    19,    42,    60,    59,    57,    51,    55,     0,
     0,    61,    60,    58,    -1,    -1,    62,    60,    -1,    60,
    -1,    63
};
/* -*-C-*-  Note some compilers choke on comments on `#line' lines.  */
#line 3 "bison.simple"

/* Skeleton output parser for bison,
   Copyright (C) 1984, 1989, 1990 Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.  */

/* As a special exception, when this file is copied by Bison into a
   Bison output file, you may use that output file without restriction.
   This special exception was added by the Free Software Foundation
   in version 1.24 of Bison.  */

#ifndef alloca
#ifdef __GNUC__
#define alloca __builtin_alloca
#else /* not GNU C.  */
#if (!defined (__STDC__) && defined (sparc)) || defined (__sparc__) || defined (__sparc) || defined (__sgi)
#include <alloca.h>
#else /* not sparc */
#if defined (MSDOS) && !defined (__TURBOC__)
#include <malloc.h>
#else /* not MSDOS, or __TURBOC__ */
#if defined(_AIX)
#include <malloc.h>
 #pragma alloca
#else /* not MSDOS, __TURBOC__, or _AIX */
#ifdef __hpux
#ifdef __cplusplus
extern "C" {
void *alloca (unsigned int);
};
#else /* not __cplusplus */
void *alloca ();
#endif /* not __cplusplus */
#endif /* __hpux */
#endif /* not _AIX */
#endif /* not MSDOS, or __TURBOC__ */
#endif /* not sparc.  */
#endif /* not GNU C.  */
#endif /* alloca not defined.  */

/* This is the parser code that is written into each bison parser
  when the %semantic_parser declaration is not specified in the grammar.
  It was written by Richard Stallman by simplifying the hairy parser
  used when %semantic_parser is specified.  */

/* Note: there must be only one dollar sign in this file.
   It is replaced by the list of actions, each action
   as one case of the switch.  */

#define yyerrok		(yyerrstatus = 0)
#define yyclearin	(yychar = YYEMPTY)
#define YYEMPTY		-2
#define YYEOF		0
#define YYACCEPT	return(0)
#define YYABORT 	return(1)
#define YYERROR		goto yyerrlab1
/* Like YYERROR except do call yyerror.
   This remains here temporarily to ease the
   transition to the new meaning of YYERROR, for GCC.
   Once GCC version 2 has supplanted version 1, this can go.  */
#define YYFAIL		goto yyerrlab
#define YYRECOVERING()  (!!yyerrstatus)
#define YYBACKUP(token, value) \
do								\
  if (yychar == YYEMPTY && yylen == 1)				\
    { yychar = (token), yylval = (value);			\
      yychar1 = YYTRANSLATE (yychar);				\
      YYPOPSTACK;						\
      goto yybackup;						\
    }								\
  else								\
    { yyerror ("syntax error: cannot back up"); YYERROR; }	\
while (0)

#define YYTERROR	1
#define YYERRCODE	256

#ifndef YYPURE
#define YYLEX		yylex()
#endif

#ifdef YYPURE
#ifdef YYLSP_NEEDED
#ifdef YYLEX_PARAM
#define YYLEX		yylex(&yylval, &yylloc, YYLEX_PARAM)
#else
#define YYLEX		yylex(&yylval, &yylloc)
#endif
#else /* not YYLSP_NEEDED */
#ifdef YYLEX_PARAM
#define YYLEX		yylex(&yylval, YYLEX_PARAM)
#else
#define YYLEX		yylex(&yylval)
#endif
#endif /* not YYLSP_NEEDED */
#endif

/* If nonreentrant, generate the variables here */

#ifndef YYPURE

int	yychar;			/*  the lookahead symbol		*/
YYSTYPE	yylval;			/*  the semantic value of the		*/
				/*  lookahead symbol			*/

#ifdef YYLSP_NEEDED
YYLTYPE yylloc;			/*  location data for the lookahead	*/
				/*  symbol				*/
#endif

int yynerrs;			/*  number of parse errors so far       */
#endif  /* not YYPURE */

#if YYDEBUG != 0
int yydebug;			/*  nonzero means print parse trace	*/
/* Since this is uninitialized, it does not stop multiple parsers
   from coexisting.  */
#endif

/*  YYINITDEPTH indicates the initial size of the parser's stacks	*/

#ifndef	YYINITDEPTH
#define YYINITDEPTH 200
#endif

/*  YYMAXDEPTH is the maximum size the stacks can grow to
    (effective only if the built-in stack extension method is used).  */

#if YYMAXDEPTH == 0
#undef YYMAXDEPTH
#endif

#ifndef YYMAXDEPTH
#define YYMAXDEPTH 10000
#endif

/* Prevent warning if -Wstrict-prototypes.  */
#ifdef __GNUC__
int yyparse (void);
#endif

#if __GNUC__ > 1		/* GNU C and GNU C++ define this.  */
#define __yy_memcpy(FROM,TO,COUNT)	__builtin_memcpy(TO,FROM,COUNT)
#else				/* not GNU C or C++ */
#ifndef __cplusplus

/* This is the most reliable way to avoid incompatibilities
   in available built-in functions on various systems.  */
static void
__yy_memcpy (from, to, count)
     char *from;
     char *to;
     int count;
{
  register char *f = from;
  register char *t = to;
  register int i = count;

  while (i-- > 0)
    *t++ = *f++;
}

#else /* __cplusplus */

/* This is the most reliable way to avoid incompatibilities
   in available built-in functions on various systems.  */
static void
__yy_memcpy (char *from, char *to, int count)
{
  register char *f = from;
  register char *t = to;
  register int i = count;

  while (i-- > 0)
    *t++ = *f++;
}

#endif
#endif

#line 192 "bison.simple"

/* The user can define YYPARSE_PARAM as the name of an argument to be passed
   into yyparse.  The argument should have type void *.
   It should actually point to an object.
   Grammar actions can access the variable by casting it
   to the proper pointer type.  */

#ifdef YYPARSE_PARAM
#define YYPARSE_PARAM_DECL void *YYPARSE_PARAM;
#else
#define YYPARSE_PARAM
#define YYPARSE_PARAM_DECL
#endif

int
yyparse(YYPARSE_PARAM)
     YYPARSE_PARAM_DECL
{
  register int yystate;
  register int yyn;
  register short *yyssp;
  register YYSTYPE *yyvsp;
  int yyerrstatus;	/*  number of tokens to shift before error messages enabled */
  int yychar1 = 0;		/*  lookahead token as an internal (translated) token number */

  short	yyssa[YYINITDEPTH];	/*  the state stack			*/
  YYSTYPE yyvsa[YYINITDEPTH];	/*  the semantic value stack		*/

  short *yyss = yyssa;		/*  refer to the stacks thru separate pointers */
  YYSTYPE *yyvs = yyvsa;	/*  to allow yyoverflow to reallocate them elsewhere */

#ifdef YYLSP_NEEDED
  YYLTYPE yylsa[YYINITDEPTH];	/*  the location stack			*/
  YYLTYPE *yyls = yylsa;
  YYLTYPE *yylsp;

#define YYPOPSTACK   (yyvsp--, yyssp--, yylsp--)
#else
#define YYPOPSTACK   (yyvsp--, yyssp--)
#endif

  int yystacksize = YYINITDEPTH;

#ifdef YYPURE
  int yychar;
  YYSTYPE yylval;
  int yynerrs;
#ifdef YYLSP_NEEDED
  YYLTYPE yylloc;
#endif
#endif

  YYSTYPE yyval;		/*  the variable used to return		*/
				/*  semantic values from the action	*/
				/*  routines				*/

  int yylen;

#if YYDEBUG != 0
  if (yydebug)
    fprintf(stderr, "Starting parse\n");
#endif

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY;		/* Cause a token to be read.  */

  /* Initialize stack pointers.
     Waste one element of value and location stack
     so that they stay on the same level as the state stack.
     The wasted elements are never initialized.  */

  yyssp = yyss - 1;
  yyvsp = yyvs;
#ifdef YYLSP_NEEDED
  yylsp = yyls;
#endif

/* Push a new state, which is found in  yystate  .  */
/* In all cases, when you get here, the value and location stacks
   have just been pushed. so pushing a state here evens the stacks.  */
yynewstate:

  *++yyssp = yystate;

  if (yyssp >= yyss + yystacksize - 1)
    {
      /* Give user a chance to reallocate the stack */
      /* Use copies of these so that the &'s don't force the real ones into memory. */
      YYSTYPE *yyvs1 = yyvs;
      short *yyss1 = yyss;
#ifdef YYLSP_NEEDED
      YYLTYPE *yyls1 = yyls;
#endif

      /* Get the current used size of the three stacks, in elements.  */
      int size = yyssp - yyss + 1;

#ifdef yyoverflow
      /* Each stack pointer address is followed by the size of
	 the data in use in that stack, in bytes.  */
#ifdef YYLSP_NEEDED
      /* This used to be a conditional around just the two extra args,
	 but that might be undefined if yyoverflow is a macro.  */
      yyoverflow("parser stack overflow",
		 &yyss1, size * sizeof (*yyssp),
		 &yyvs1, size * sizeof (*yyvsp),
		 &yyls1, size * sizeof (*yylsp),
		 &yystacksize);
#else
      yyoverflow("parser stack overflow",
		 &yyss1, size * sizeof (*yyssp),
		 &yyvs1, size * sizeof (*yyvsp),
		 &yystacksize);
#endif

      yyss = yyss1; yyvs = yyvs1;
#ifdef YYLSP_NEEDED
      yyls = yyls1;
#endif
#else /* no yyoverflow */
      /* Extend the stack our own way.  */
      if (yystacksize >= YYMAXDEPTH)
	{
	  yyerror("parser stack overflow");
	  return 2;
	}
      yystacksize *= 2;
      if (yystacksize > YYMAXDEPTH)
	yystacksize = YYMAXDEPTH;
      yyss = (short *) alloca (yystacksize * sizeof (*yyssp));
      __yy_memcpy ((char *)yyss1, (char *)yyss, size * sizeof (*yyssp));
      yyvs = (YYSTYPE *) alloca (yystacksize * sizeof (*yyvsp));
      __yy_memcpy ((char *)yyvs1, (char *)yyvs, size * sizeof (*yyvsp));
#ifdef YYLSP_NEEDED
      yyls = (YYLTYPE *) alloca (yystacksize * sizeof (*yylsp));
      __yy_memcpy ((char *)yyls1, (char *)yyls, size * sizeof (*yylsp));
#endif
#endif /* no yyoverflow */

      yyssp = yyss + size - 1;
      yyvsp = yyvs + size - 1;
#ifdef YYLSP_NEEDED
      yylsp = yyls + size - 1;
#endif

#if YYDEBUG != 0
      if (yydebug)
	fprintf(stderr, "Stack size increased to %d\n", yystacksize);
#endif

      if (yyssp >= yyss + yystacksize - 1)
	YYABORT;
    }

#if YYDEBUG != 0
  if (yydebug)
    fprintf(stderr, "Entering state %d\n", yystate);
#endif

  goto yybackup;
 yybackup:

/* Do appropriate processing given the current state.  */
/* Read a lookahead token if we need one and don't already have one.  */
/* yyresume: */

  /* First try to decide what to do without reference to lookahead token.  */

  yyn = yypact[yystate];
  if (yyn == YYFLAG)
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* yychar is either YYEMPTY or YYEOF
     or a valid token in external form.  */

  if (yychar == YYEMPTY)
    {
#if YYDEBUG != 0
      if (yydebug)
	fprintf(stderr, "Reading a token: ");
#endif
      yychar = YYLEX;
    }

  /* Convert token to internal form (in yychar1) for indexing tables with */

  if (yychar <= 0)		/* This means end of input. */
    {
      yychar1 = 0;
      yychar = YYEOF;		/* Don't call YYLEX any more */

#if YYDEBUG != 0
      if (yydebug)
	fprintf(stderr, "Now at end of input.\n");
#endif
    }
  else
    {
      yychar1 = YYTRANSLATE(yychar);

#if YYDEBUG != 0
      if (yydebug)
	{
	  fprintf (stderr, "Next token is %d (%s", yychar, yytname[yychar1]);
	  /* Give the individual parser a way to print the precise meaning
	     of a token, for further debugging info.  */
#ifdef YYPRINT
	  YYPRINT (stderr, yychar, yylval);
#endif
	  fprintf (stderr, ")\n");
	}
#endif
    }

  yyn += yychar1;
  if (yyn < 0 || yyn > YYLAST || yycheck[yyn] != yychar1)
    goto yydefault;

  yyn = yytable[yyn];

  /* yyn is what to do for this token type in this state.
     Negative => reduce, -yyn is rule number.
     Positive => shift, yyn is new state.
       New state is final state => don't bother to shift,
       just return success.
     0, or most negative number => error.  */

  if (yyn < 0)
    {
      if (yyn == YYFLAG)
	goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }
  else if (yyn == 0)
    goto yyerrlab;

  if (yyn == YYFINAL)
    YYACCEPT;

  /* Shift the lookahead token.  */

#if YYDEBUG != 0
  if (yydebug)
    fprintf(stderr, "Shifting token %d (%s), ", yychar, yytname[yychar1]);
#endif

  /* Discard the token being shifted unless it is eof.  */
  if (yychar != YYEOF)
    yychar = YYEMPTY;

  *++yyvsp = yylval;
#ifdef YYLSP_NEEDED
  *++yylsp = yylloc;
#endif

  /* count tokens shifted since error; after three, turn off error status.  */
  if (yyerrstatus) yyerrstatus--;

  yystate = yyn;
  goto yynewstate;

/* Do the default action for the current state.  */
yydefault:

  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;

/* Do a reduction.  yyn is the number of a rule to reduce with.  */
yyreduce:
  yylen = yyr2[yyn];
  if (yylen > 0)
    yyval = yyvsp[1-yylen]; /* implement default value of the action */

#if YYDEBUG != 0
  if (yydebug)
    {
      int i;

      fprintf (stderr, "Reducing via rule %d (line %d), ",
	       yyn, yyrline[yyn]);

      /* Print the symbols being reduced, and their result.  */
      for (i = yyprhs[yyn]; yyrhs[i] > 0; i++)
	fprintf (stderr, "%s ", yytname[yyrhs[i]]);
      fprintf (stderr, " -> %s\n", yytname[yyr1[yyn]]);
    }
#endif


  switch (yyn) {

case 1:
#line 56 "rme-bison.y"
{yyval.node = makenode(PROGRAM,yyvsp[-1].node,yyvsp[0].node,NULL,0,"var declaration"); root=yyval.node;;
    break;}
case 2:
#line 58 "rme-bison.y"
{yyval.node = makenode(VAR,yyvsp[0].node,NULL,NULL,0,NULL);;
    break;}
case 3:
#line 61 "rme-bison.y"
{yyval.node = makenode(MESH,yyvsp[0].node,NULL,NULL,0,NULL);;
    break;}
case 4:
#line 62 "rme-bison.y"
{yyval.node = makenode(REGISTER,yyvsp[0].node,NULL,NULL,0,NULL);;
    break;}
case 5:
#line 63 "rme-bison.y"
{yyval.node = makenode(OUTPUT,yyvsp[0].node,NULL,NULL,0,NULL);;
    break;}
case 6:
#line 64 "rme-bison.y"
{yyval.node = makenode(INPUT,yyvsp[0].node,NULL,NULL,0,NULL);;
    break;}
case 7:
#line 67 "rme-bison.y"
{;
    break;}
case 8:
#line 69 "rme-bison.y"
{;
    break;}
case 9:
#line 71 "rme-bison.y"
{;
    break;}
case 10:
#line 73 "rme-bison.y"
{;
    break;}
case 11:
#line 75 "rme-bison.y"
{;
    break;}
case 12:
#line 77 "rme-bison.y"
{yyval.node = getLeaf(MESH,yyvsp[-1].code,0,"dimention declaration");;
    break;}
case 13:
#line 79 "rme-bison.y"
{;
    break;}
case 14:
#line 81 "rme-bison.y"
{;
    break;}
case 15:
#line 83 "rme-bison.y"
{;
    break;}
case 16:
#line 85 "rme-bison.y"
{;
    break;}
case 17:
#line 87 "rme-bison.y"
{;
    break;}
case 18:
#line 89 "rme-bison.y"
{;
    break;}
case 19:
#line 92 "rme-bison.y"
{;
    break;}
case 20:
#line 94 "rme-bison.y"
{;
    break;}
case 21:
#line 96 "rme-bison.y"
{;
    break;}
case 22:
#line 98 "rme-bison.y"
{;
    break;}
case 23:
#line 100 "rme-bison.y"
{;
    break;}
case 24:
#line 102 "rme-bison.y"
{ yyval.node = makenode(ADD,yyvsp[-2].node,yyvsp[0].node,NULL,0,NULL);;
    break;}
case 25:
#line 103 "rme-bison.y"
{ yyval.node = makenode(MIN,yyvsp[-2].node,yyvsp[0].node,NULL,0,NULL);;
    break;}
case 26:
#line 104 "rme-bison.y"
{ yyval.node = makenode(MUL,yyvsp[-2].node,yyvsp[0].node,NULL,0,NULL);;
    break;}
case 27:
#line 105 "rme-bison.y"
{ yyval.node = makenode(DIV,yyvsp[-2].node,yyvsp[0].node,NULL,0,NULL);;
    break;}
case 28:
#line 106 "rme-bison.y"
{ yyval.node = makenode(MOD,yyvsp[-2].node,yyvsp[0].node,NULL,0,NULL);;
    break;}
case 29:
#line 107 "rme-bison.y"
{ yyval.node = makenode(LES,yyvsp[-2].node,yyvsp[0].node,NULL,0,NULL);;
    break;}
case 30:
#line 108 "rme-bison.y"
{ yyval.node = makenode(LEQ,yyvsp[-2].node,yyvsp[0].node,NULL,0,NULL);;
    break;}
case 31:
#line 109 "rme-bison.y"
{ yyval.node = makenode(EQU,yyvsp[-2].node,yyvsp[0].node,NULL,0,NULL);;
    break;}
case 32:
#line 110 "rme-bison.y"
{ yyval.node = makenode(NEQ,yyvsp[-2].node,yyvsp[0].node,NULL,0,NULL);;
    break;}
case 33:
#line 111 "rme-bison.y"
{ yyval.node = makenode(GRE,yyvsp[-2].node,yyvsp[0].node,NULL,0,NULL);;
    break;}
case 34:
#line 112 "rme-bison.y"
{ yyval.node = makenode(GEQ,yyvsp[-2].node,yyvsp[0].node,NULL,0,NULL);;
    break;}
case 35:
#line 113 "rme-bison.y"
{ yyval.node = yyvsp[-1].node; ;
    break;}
case 36:
#line 114 "rme-bison.y"
{ yyval.node = makenode(MIN,yyvsp[0].node,NULL,NULL,0,NULL); ;
    break;}
case 37:
#line 115 "rme-bison.y"
{ yyval.node =makenode(NOT,yyvsp[0].node,NULL,NULL,0,NULL); ;
    break;}
case 38:
#line 116 "rme-bison.y"
{ yyval.node = yyvsp[0].node; ;
    break;}
case 39:
#line 119 "rme-bison.y"
{ yyval.node = genLeaf(INTCONST,yyvsp[0].code,0,NULL); ;
    break;}
case 40:
#line 120 "rme-bison.y"
{ yyval.node = genLeaf(REALCONST,0,yyvsp[0].real,NULL);;
    break;}
case 41:
#line 121 "rme-bison.y"
{ yyval.node = genLeaf(TRUE,0,0,NULL); ;
    break;}
case 42:
#line 122 "rme-bison.y"
{ yyval.node = genLeaf(FALSE,0,0,NULL); ;
    break;}
}
   /* the action file gets copied in in place of this dollarsign */
#line 487 "bison.simple"

  yyvsp -= yylen;
  yyssp -= yylen;
#ifdef YYLSP_NEEDED
  yylsp -= yylen;
#endif

#if YYDEBUG != 0
  if (yydebug)
    {
      short *ssp1 = yyss - 1;
      fprintf (stderr, "state stack now");
      while (ssp1 != yyssp)
	fprintf (stderr, " %d", *++ssp1);
      fprintf (stderr, "\n");
    }
#endif

  *++yyvsp = yyval;

#ifdef YYLSP_NEEDED
  yylsp++;
  if (yylen == 0)
    {
      yylsp->first_line = yylloc.first_line;
      yylsp->first_column = yylloc.first_column;
      yylsp->last_line = (yylsp-1)->last_line;
      yylsp->last_column = (yylsp-1)->last_column;
      yylsp->text = 0;
    }
  else
    {
      yylsp->last_line = (yylsp+yylen-1)->last_line;
      yylsp->last_column = (yylsp+yylen-1)->last_column;
    }
#endif

  /* Now "shift" the result of the reduction.
     Determine what state that goes to,
     based on the state we popped back to
     and the rule number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTBASE] + *yyssp;
  if (yystate >= 0 && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTBASE];

  goto yynewstate;

yyerrlab:   /* here on detecting error */

  if (! yyerrstatus)
    /* If not already recovering from an error, report this error.  */
    {
      ++yynerrs;

#ifdef YYERROR_VERBOSE
      yyn = yypact[yystate];

      if (yyn > YYFLAG && yyn < YYLAST)
	{
	  int size = 0;
	  char *msg;
	  int x, count;

	  count = 0;
	  /* Start X at -yyn if nec to avoid negative indexes in yycheck.  */
	  for (x = (yyn < 0 ? -yyn : 0);
	       x < (sizeof(yytname) / sizeof(char *)); x++)
	    if (yycheck[x + yyn] == x)
	      size += strlen(yytname[x]) + 15, count++;
	  msg = (char *) malloc(size + 15);
	  if (msg != 0)
	    {
	      strcpy(msg, "parse error");

	      if (count < 5)
		{
		  count = 0;
		  for (x = (yyn < 0 ? -yyn : 0);
		       x < (sizeof(yytname) / sizeof(char *)); x++)
		    if (yycheck[x + yyn] == x)
		      {
			strcat(msg, count == 0 ? ", expecting `" : " or `");
			strcat(msg, yytname[x]);
			strcat(msg, "'");
			count++;
		      }
		}
	      yyerror(msg);
	      free(msg);
	    }
	  else
	    yyerror ("parse error; also virtual memory exceeded");
	}
      else
#endif /* YYERROR_VERBOSE */
	yyerror("parse error");
    }

  goto yyerrlab1;
yyerrlab1:   /* here on error raised explicitly by an action */

  if (yyerrstatus == 3)
    {
      /* if just tried and failed to reuse lookahead token after an error, discard it.  */

      /* return failure if at end of input */
      if (yychar == YYEOF)
	YYABORT;

#if YYDEBUG != 0
      if (yydebug)
	fprintf(stderr, "Discarding token %d (%s).\n", yychar, yytname[yychar1]);
#endif

      yychar = YYEMPTY;
    }

  /* Else will try to reuse lookahead token
     after shifting the error token.  */

  yyerrstatus = 3;		/* Each real token shifted decrements this */

  goto yyerrhandle;

yyerrdefault:  /* current state does not do anything special for the error token. */

#if 0
  /* This is wrong; only states that explicitly want error tokens
     should shift them.  */
  yyn = yydefact[yystate];  /* If its default is to accept any token, ok.  Otherwise pop it.*/
  if (yyn) goto yydefault;
#endif

yyerrpop:   /* pop the current state because it cannot handle the error token */

  if (yyssp == yyss) YYABORT;
  yyvsp--;
  yystate = *--yyssp;
#ifdef YYLSP_NEEDED
  yylsp--;
#endif

#if YYDEBUG != 0
  if (yydebug)
    {
      short *ssp1 = yyss - 1;
      fprintf (stderr, "Error: state stack now");
      while (ssp1 != yyssp)
	fprintf (stderr, " %d", *++ssp1);
      fprintf (stderr, "\n");
    }
#endif

yyerrhandle:

  yyn = yypact[yystate];
  if (yyn == YYFLAG)
    goto yyerrdefault;

  yyn += YYTERROR;
  if (yyn < 0 || yyn > YYLAST || yycheck[yyn] != YYTERROR)
    goto yyerrdefault;

  yyn = yytable[yyn];
  if (yyn < 0)
    {
      if (yyn == YYFLAG)
	goto yyerrpop;
      yyn = -yyn;
      goto yyreduce;
    }
  else if (yyn == 0)
    goto yyerrpop;

  if (yyn == YYFINAL)
    YYACCEPT;

#if YYDEBUG != 0
  if (yydebug)
    fprintf(stderr, "Shifting error token, ");
#endif

  *++yyvsp = yylval;
#ifdef YYLSP_NEEDED
  *++yylsp = yylloc;
#endif

  yystate = yyn;
  goto yynewstate;
}
#line 125 "rme-bison.y"





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