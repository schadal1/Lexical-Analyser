%{
#include <stdio.h>
#include "calc.tab.h"
%}

digit	([0-9])
ID      [a-z][a-z0-9]*

%%

"printvar"	{return TOK_PRINTVAR;}

"main"  { return TOK_MAIN; }

"int"   {return TOK_INT; }

"float" {return TOK_FLOAT; };

";"	{	return TOK_SEMICOLON;	}

"+"	{	return TOK_ADD;	}

"*"	{	return TOK_MUL;	} 

"{" {   return TOK_LEFTFLOWERBRACE;  }

"}" {   return TOK_RIGHTFLOWERBRACE; } 

"(" {	return TOK_LEFTROUNDBRACE; }

")" { 	return TOK_RIGHTROUNDBRACE;}

"=" { 	return TOK_EQUALTO;	}


[ \n] 	{}

	
{digit}+	{
	sscanf(yytext, "%d", &(yylval.int_val));
	return TOK_INTNUM;
	}
	
{digit}+\.{digit}+  {
	sscanf(yytext, "%f", &(yylval.float_val));
	return TOK_FLOATNUM;
	}

{ID}+ 	{
		strcpy(yylval.id.name,yytext);
		yylval.id.type=-1;
		yylval.id.ival=-1;
		yylval.id.fval=-1;
		yylval.id.initialized=0;
		return TOK_IDENTIFIER;
        }
        
.	{
		fprintf(stderr,"Invalid character '%c', ignored\n", yytext[0]);
	}

%%


