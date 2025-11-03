%{
	int numLinha = 1; /* variavel para contar numero de linhas */
	#include "sintatico.h" 
	char atomo[100];
	void msg(char *);
%}

identificador   [a-zA-Z][a-zA-Z0-9]*
numero          [0-9]+
espaco          [ \t]+
novalinha       [\n]

%x coment

%%

programa        { return T_PROGRAMA; }
inicio        	{ return T_INICIO; }
fimprograma     { return T_FIM; }
leia        	{ return T_LEIA; }
escreva        	{ return T_ESCREVA; }
se        		{ return T_SE; }
entao        	{ return T_ENTAO; }
senao        	{ return T_SENAO; }
fimse        	{ return T_FIMSE; }
enquanto        { return T_ENQT; }
faca        	{ return T_FACA; }
fimenquanto     { return T_FIMENQT; }

"+"        	    { return T_MAIS; }
"-"        	    { return T_MENOS; }
"*"        	    { return T_VEZES; }
"div"      	    { return T_DIV; }
"<-"        	{ return T_ATRIB; }
">"        	    { return T_MAIOR; }
"<"        	    { return T_MENOR; }
"="        	    { return T_IGUAL; }

"e"            	{ return T_E; }
"ou"        	{ return T_OU; }
"nao"        	{ return T_NAO; }

"("        	    { return T_ABRE; }
")"            	{ return T_FECHA; }

inteiro        	{ return T_INTEIRO; }
logico        	{ return T_LOGICO; }
"V"        	    { return T_V; }
"F"            	{ return T_F; }
{identificador} { 
                    strcpy (atomo, yytext);
					return T_IDENTIF;
                }
{numero}        { 
                    strcpy (atomo, yytext);
					return T_NUMERO;
                }
{espaco}	    /* nada */
{novalinha}  	++numLinha;
"//".*		    /* nada */
"/*"		    BEGIN(coment);
<coment>"*/"	BEGIN(INITIAL);
<coment>.*	    /* nada */
<coment>\n	    ++numLinha;

.		        msg ("ERRO LEXICO - simbolo desconhecido!");

%%

int yywrap (void) { return 1; }

void msg (char *s) {
	printf("\nLinha %d: %s\n\n", numLinha, s);
	exit (10);
}