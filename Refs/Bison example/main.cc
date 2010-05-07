/* main.cc */
/* for testing the byson.y file only 
*	edit the Makefile file 
*/

#include "heading.h"

// prototype of bison-generated parser function
int yyparse();

int main(int argc, char **argv)
{
  if ((argc > 1) && (freopen(argv[1], "r", stdin) == NULL))
  {
	/* cerr << argv[0] << ": File " << argv[1] << " cannot be opened.\n"; */   /* for C++ compiler. need to edit Makefile */
    fprintf(stderr,"%s: FILE %s cannot be opened.\n",argv[0],argv[1]); 			/* for c copiler. need to edit Makefile */
    exit( 1 );
  }
  
  yyparse();

  return 0;
}

