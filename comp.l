%{
	#include <stdio.h>
	#include <stdlib.h>
	#include "comp.tab.h"
	

	
	char str_buf[4096];
	
%}

%option noyywrap
%option case-insensitive
%option yylineno



%x STRING



%%








[1-9][0-9]*|0				{ printf("\%s",yytext);return T_NUMBER;}
[0-9]+\.[0-9]*				{ printf("\%s",yytext);return T_FLOATNUM;}
[+|-]?[0-9]*(\.[0-9]*(e[+|-]?)?[0-9]*)?	{ printf("\%s",yytext);return T_JNUMBER;}


\(              		 	{ return T_LPAREN; }
\)               			{ return T_RPAREN; }
;                			{ return T_SEMI; }
:					{ return T_COLON; }
,                			{ return T_COMMA; }
\[                			{ return T_LBRACK; }
\]               			{ return T_RBRACK; }
\{               			{ return T_LBRACE; }
\}                			{ return T_RBRACE; }


\"last\"				{ return T_LAST; }


\"gameId\"			   	{ return T_GAMEID; }	
\"drawId\"			   	{ return T_DRAWID; }
\"drawTime\"		   		{ return T_DRAWTIME;}
\"status\"			  	{ return T_STATUS;}
\"drawBreak\"		  		{ return T_DRAWBREAK;}
\"visualDraw\"		   		{ return T_VISUALDRAW;}
\"pricePoints\"		   		{ return T_PRICEPOINTS;}
\"amount\"			  	{ return T_AMOUNT;}
\"winningNumbers\"	   		{ return T_WINNINGNUMBERS;}
\"list\"			   	{ return T_LIST;}
\"bonus\"			   	{ return T_BONUS;}

\"prizeCategories\"	   		{ return T_PRIZECATEGORIES;}
\"id\"			       		{ return T_ID;}
\"divident\"				{ return T_DIVIDENT;}
\"winners\"	           		{ return T_WINNERS;}
\"distributed\"		   		{ return T_DISTRIBUTED;}
\"jackpot\"			   	{ return T_JACKPOT;}
\"fixed\"	           		{ return T_FIXED;}
\"categoryType\"		        { return T_CATEGORYTYPE;}
\"gameType\"            		{ return T_GAMETYPE;}
\"minimumDistributed\"  		{ return T_MINIMUMDISTRIBUTED;}


\"wagerStatistics\"	   		{ return T_WAGERSTATISTICS;}
\"columns\"			   	{ return T_COLUMNS;}
\"wagers\"			   	{ return T_WAGERS;}
\"addOn\"			       	{ return T_ADDON;}

\"active\"				{ return T_ACTIVE; }

\"                          { strcpy(str_buf,""); BEGIN(STRING);}
<STRING>\"                  { BEGIN(INITIAL); printf(" \"\%s\"", str_buf); return T_JSTRING;}             
<STRING>(\\.|[^"\\])    	{strcat(str_buf, yytext); }
<STRING>(\\\n|\\\r\n)   	{ }
<STRING>(\n|\r\n)           {printf("new line found without \\");}
<STRING><<EOF>>             {printf("End of string without closing it ");}
<STRING>.                   {printf("Unknown character");}



" "							{	}
[ \t\n\r]						{}

\r\n 							{   }




.			{ printf("Unknown\n"); }
<<EOF>>		{ return 0; }





%%


