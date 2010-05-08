typedef union
   { int code;
     double real;
     char *string;
     NODE node;
   } YYSTYPE;
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


extern YYSTYPE yylval;
