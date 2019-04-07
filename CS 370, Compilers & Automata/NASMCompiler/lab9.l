%{

int mydebug=1;
int lineno = 1;
#include "ast.h"
#include "y.tab.h"

%}


%%
int			{if (mydebug) fprintf(stderr, "Reserved word 'int' found\n");
				return(INT);}
void			{if (mydebug) fprintf(stderr, "Reserved word 'void' found\n");
				return(VOID);}
while			{if (mydebug) fprintf(stderr, "Reserved word 'while' found\n");
				return(WHILE);}
if			{if (mydebug) fprintf(stderr, "Reserved word 'if' found\n");
				return(IF);}
then			{if (mydebug) fprintf(stderr, "Reserved word 'then' found\n");
				return(THEN);}
else			{if (mydebug) fprintf(stderr, "Reserved word 'else' found\n");
				return(ELSE);}
read			{if (mydebug) fprintf(stderr, "Reserved word 'read' found\n");
				return(READ);}
write			{if (mydebug) fprintf(stderr, "Reserved word 'write' found\n");
				return(WRITE);}
return			{if (mydebug) fprintf(stderr, "Reserved word 'return' found\n");
				return(RETURN);}
\".*\"			{if (mydebug) fprintf (stderr, "String found\n");
				yylval.string=strdup(yytext);
				return(STRING);}
[a-zA-Z][a-zA-Z0-9]*	{if (mydebug) fprintf(stderr, "Variable name found\n");
				yylval.string=strdup(yytext); 
				return(ID);}
[0-9][0-9]*		{if (mydebug) fprintf(stderr,"NUM found\n"); 
                       		yylval.value=atoi((const char *)yytext); 
				return(NUM);}
[ \t]			{if (mydebug) fprintf(stderr,"");}
[(){}\[\]\-+*/%&|,=;] 	{if (mydebug) fprintf(stderr,"return a token %c\n",*yytext); 
                       		return(*yytext);}
"<="			{if (mydebug) fprintf(stderr, "Less than or equal found\n");
				return(LE);}
">="			{if (mydebug) fprintf(stderr, "greater than or equal found\n");
				return(GE);}
"=="			{if (mydebug) fprintf(stderr, "Compare equal found\n");
				return(EQ);}
"!="			{if (mydebug) fprintf(stderr, "Not equal found\n");
				return(NE);}
">"			{if (mydebug) fprintf(stderr, "Greater than found\n");
				return(GT);}
"<"			{if (mydebug) fprintf(stderr, "Less than found\n");
				return(LT);}
\n 			{ if (mydebug) fprintf(stderr,"cariage return %c\n",*yytext);
				lineno++;}

%%

int yywrap(void)
{ return 1;}
