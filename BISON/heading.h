/* heading.h */

#define YY_NO_UNPUT

#include <stdlib.h>
#include <stdio.h>
#include <string.h>


typedef struct node {    /* abstract syntax tree record */
	int op;      /* type of operation */
        int val;     /* value of a number */
        double rval; /* value of real number*/ 
        char *name; /* hold names of identfiers*/
        int children; /*number of children */
		struct node *s1,*s2,*s3, *s4;  /* urguments */
} *NODE;


NODE makenode(int op, NODE s1, NODE s2, NODE s3, NODE s4,int val,char *id);
NODE genLeaf(int op, int val, double rval,char *id);

extern NODE root;