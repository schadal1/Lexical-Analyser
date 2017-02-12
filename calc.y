
%{
#include <stdio.h>
#include<stdlib.h>
#include <string.h>
%}

%token TOK_SEMICOLON
%token TOK_ADD
%token TOK_PRINTVAR
%token TOK_MUL
%token TOK_LEFTFLOWERBRACE
%token TOK_RIGHTFLOWERBRACE
%token TOK_LEFTROUNDBRACE
%token TOK_RIGHTROUNDBRACE
%token TOK_EQUALTO
%token TOK_INT
%token TOK_FLOAT
%token TOK_INTNUM
%token TOK_FLOATNUM
%token TOK_IDENTIFIER
%token TOK_MAIN

%union{
        int int_val;
        float float_val;
        struct identifier id;
        }

%code requires {

struct identifier
{
char name[100];
int type;
int ival;
float fval;
int initialized;
};
}
%code {
struct identifier idlist[10000];
int j=0;

struct identifier* retrieve(struct identifier id)
{
        int k;
        //fprintf(stderr,"%d",j);
        for(k=0;k<=j;k++){
                //fprintf(stderr,"%s\n",idlist[k].name);
                if(!strcmp(id.name,idlist[k].name)){
                        //fprintf(stderr,"%s\n",idlist[k].name);
                        return &idlist[k];
                }
        }
        return NULL;
}
}

%type <int_val> TOK_INTNUM
%type <float_val> TOK_FLOATNUM
%type <id> TOK_IDENTIFIER
%type <id> expr

%left TOK_ADD
%left TOK_MUL

%%

program : TOK_MAIN TOK_LEFTROUNDBRACE TOK_RIGHTROUNDBRACE  TOK_LEFTFLOWERBRACE  stmts TOK_RIGHTFLOWERBRACE
;

stmts:
        | stmts stmt TOK_SEMICOLON
        ;

stmt :
 | TOK_PRINTVAR TOK_IDENTIFIER
                {
                        struct identifier *id = retrieve($2);
                        if(id){
                                if(id->type==0)
                                fprintf(stdout,"%d\n", id->ival);
                                else if(id->type==1)
                                fprintf(stdout,"%f\n",id->fval);
                                }
                        else{
                                fprintf(stderr,"parsing error");
                                return -1;
                                }
                }
        | TOK_INT TOK_IDENTIFIER
                {
                        struct identifier *id=retrieve($2);
                        struct identifier destid;
                        if(id)
                        {
                                fprintf(stderr,"%s parsing error.\n",id->name);
                                return -1;
                        }
                        j++;
                        idlist[j].type=0;
                        strcpy(idlist[j].name,$2.name);
                        //fprintf(stderr,"j=%d type=%d name=%s",j,idlist[j].type,idlist[j].name);

                }
        | TOK_FLOAT TOK_IDENTIFIER
                {
                        struct identifier *id=retrieve($2);
                        struct identifier destid;
                        if(id)
                        {
                                fprintf(stderr,"%s already defined.\n",id->name);
                                return -1;
   }
                        j++;
                        idlist[j].type=1;
                        strcpy(idlist[j].name,$2.name);
                        //fprintf(stderr,"j=%d type=%d name=%s",j,idlist[j].type,idlist[j].name);
                }
        |TOK_IDENTIFIER TOK_EQUALTO expr
                {
                        struct identifier *id=retrieve($1);
                        if(!id)
                        {
                                fprintf(stderr,"%s parsing error.\n",$1.name);
                                return -1;
                        }
                        if(id->type != $3.type){
                                        fprintf(stderr," type error ");
                                        return -1;
                                }
                                else if(id->type==1)
                                        id->fval=$3.fval;
                                else
                                        id->ival = $3.ival;
                }

        ;

expr : TOK_IDENTIFIER
                {
                        struct identifier *id=retrieve($1);
                        if(!id)
                        {
                                fprintf(stderr,"%s not defined.\n",$1.name);
                                return -1;
                        }
                        $$ = *id;
                }
        |TOK_INTNUM
   {
                        $$.ival=$1;
                        $$.type=0;
                }
        |TOK_FLOATNUM
         {
                        $$.fval=$1;
                        $$.type=1;
         }
        | expr TOK_ADD expr
                {
                        if($1.type != $3.type){
                                fprintf(stderr," type error");
                                return -1;
                                }
                        else
                           {     if($1.type==0){
                                        $$.ival = $1.ival + $3.ival;
                                        $$.type = 0;
                                }
                                else{
                                        $$.fval = $1.fval + $3.fval;
                                        $$.type = 1;
                                }}
                }
        | expr TOK_MUL expr
                {
                        if($1.type != $3.type){
                                fprintf(stderr,"type error");
                                return -1;
                                }
                        else
                                if($1.type==0){
                                        $$.ival = $1.ival * $3.ival;
                                        $$.type = 0;
                                }
                           
                                else{
                                        $$.fval = $1.fval * $3.fval;
                                        $$.type = 1;
                                }
                }

        ;

%%
int yyerror(char *s){
fprintf(stderr, "type error ");
return 0;
 }
int main()
{
struct identifier idlist[10000];
int j=0;
yyparse();
return 0;
 }


