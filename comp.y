%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern FILE *yyin;

extern int yylex(); //trava vres thn kai ferthn apo kapou

extern char* yytext;
extern int yyparse();
extern int yylineno;

void yyerror(const char* err);

void checkgame_id(char* a);
void numbers_in_list(char* b);
void number_of_numbers(int c);

int counter = 0 ;


%}


%token T_EOF      			
%token T_NUMBER     			
%token T_FLOATNUM    			
%token T_JNUMBER    			

%token T_LPAREN   			
%token T_RPAREN   			
%token T_SEMI      			
%token T_COLON      			
%token T_COMMA     			
%token T_ASSIGN    			
%token T_LBRACK    			
%token T_RBRACK    			
%token T_LBRACE    			
%token T_RBRACE  
  			
%token T_LAST 				
%token T_GAMEID				
%token T_DRAWID				
%token T_DRAWTIME					
%token T_STATUS				
%token T_DRAWBREAK			
%token T_VISUALDRAW				
%token T_PRICEPOINTS				
%token T_AMOUNT				
%token T_WINNINGNUMBERS				
%token T_LIST				
%token T_BONUS				
%token T_PRIZECATEGORIES					
%token T_ID				
%token T_DIVIDENT				
%token T_WINNERS				
%token T_DISTRIBUTED					
%token T_JACKPOT				
%token T_FIXED				
%token T_CATEGORYTYPE			
%token T_GAMETYPE					
%token T_MINIMUMDISTRIBUTED						
%token T_WAGERSTATISTICS				
%token T_COLUMNS				
%token T_WAGERS				
%token T_ADDON				
%token T_ACTIVE				
%token T_JSTRING			
%token T_BOOLEAN

%start program			


%%
program: json_file;

json_file: T_LBRACE {printf("{\n");} last previous active running T_RBRACE {printf("}\n");};

previous: previous_res | previous T_COMMA{printf(",\n");} previous_res;

running: running_res | running T_COMMA{printf(",\n");} running_res;


previous_res:  gameId| drawId | drawTime| status_pre | drawBreak | visualDraw
      | pricePoints| winningNumbers | prizeCategories| wagerStatistics
      |T_RBRACE {printf("}\n");};
				
running_res:    gameId| drawId | drawTime| status_run | drawBreak | visualDraw
      | pricePoints| winningNumbers | prizeCategories| wagerStatistics_run
      |T_RBRACE {printf("}\n");};
      
				;
last:  T_LAST T_COLON{printf("\t\"last\": ");} T_LBRACE {printf("{\n");};
active: T_ACTIVE T_COLON{printf("\t\"active\": ");} T_LBRACE {printf("{\n");};

gameId: T_GAMEID {printf("\t\t\"gameId\"");} T_COLON {printf(":");}   T_NUMBER{checkgame_id(yytext);};

drawId: T_DRAWID {printf("\t\t\"drawId\"");} T_COLON {printf(":");} T_NUMBER;

drawTime: T_DRAWTIME {printf("\t\t\"drawTime\"");} T_COLON {printf(":");} T_NUMBER ;

status_pre: T_STATUS {printf("\t\t\"status\"");} T_COLON {printf(":");} T_JSTRING;

status_run: T_STATUS {printf("\t\t\"status\"");} T_COLON {printf(":");} T_ACTIVE {printf("\"active\"");};

drawBreak: T_DRAWBREAK{printf("\t\t\"drawBreak\"");} T_COLON {printf(":");} T_NUMBER ;

visualDraw: T_VISUALDRAW{printf("\t\t\"visualDraw\"");} T_COLON {printf(":");} T_NUMBER ;

pricePoints: T_PRICEPOINTS{printf("\t\t\"pricePoints\"");} T_COLON {printf(":");} T_LBRACE {printf("{\n");} amount T_RBRACE {printf("\n\t\t }");};
amount: T_AMOUNT {printf("\t\t\"amount\"");} T_COLON {printf(":");} T_FLOATNUM;

winningNumbers: T_WINNINGNUMBERS T_COLON T_LBRACE {printf("\t\t\"winningNumbers\": {\n");}  list|bonus T_RBRACE {printf("\n\t\t}");};
list: T_LIST {printf("\t\t\"list\"");} T_COLON {printf(":");} numberlist;
bonus: T_BONUS {printf("\t\t\"bonus\"");} T_COLON {printf(":");} T_LBRACK {printf("[\n");} {printf("\t\t\t");}T_NUMBER T_RBRACK {printf("\n\t\t]");};

numberlist: T_LBRACK {printf("[\n");} numbers{number_of_numbers(counter); } T_RBRACK {printf("\n\t\t]");};
numbers: {printf("\t\t\t");}T_NUMBER{numbers_in_list(yytext); }  T_COMMA {printf(",\n");}
         {printf("\t\t\t");}T_NUMBER{numbers_in_list(yytext); }  T_COMMA {printf(",\n");}
         {printf("\t\t\t");}T_NUMBER{numbers_in_list(yytext); }  T_COMMA {printf(",\n");}
         {printf("\t\t\t");}T_NUMBER{numbers_in_list(yytext); }  T_COMMA {printf(",\n");}
         {printf("\t\t\t");}T_NUMBER{numbers_in_list(yytext); } ;




prizeCategories: T_PRIZECATEGORIES T_COLON T_LBRACK {printf("\t\t\"prizeCategories\": [\n");} groups T_RBRACK {printf("\n\t\t]");};


groups: group1 T_COMMA{printf(",\n");} 
        group2 T_COMMA{printf(",\n");} 
        group2 T_COMMA{printf(",\n");}
        group2 T_COMMA{printf(",\n");}
        group2 T_COMMA{printf(",\n");}
        group2 T_COMMA{printf(",\n");}
        group2 T_COMMA{printf(",\n");}
        group2;
        

group1: T_LBRACE {printf("\t\t{\n");}
        first_id T_COMMA{printf(",\n");}
        divident T_COMMA{printf(",\n");}
        winners T_COMMA{printf(",\n");}
        distributed T_COMMA{printf(",\n");}
        jackpot T_COMMA{printf(",\n");}
        fixed T_COMMA{printf(",\n");}
        categoryType T_COMMA{printf(",\n");}
        gameType T_COMMA{printf(",\n");}
        minimumDistributed 
        T_RBRACE {printf("\n\t\t}");};
            
group2: T_LBRACE {printf("\t\t{\n");}
        rest_ids T_COMMA{printf(",\n");}
        divident T_COMMA{printf(",\n");}
        winners T_COMMA{printf(",\n");}
        distributed T_COMMA{printf(",\n");}
        jackpot T_COMMA{printf(",\n");}
        fixed T_COMMA{printf(",\n");}
        categoryType T_COMMA{printf(",\n");}
        gameType 
        T_RBRACE {printf("\n\t\t}");};
         

first_id: T_ID {printf("\t\t\t\"id\"");} T_COLON {printf(":");} T_NUMBER ;
rest_ids: T_ID {printf("\t\t\t\"id\"");} T_COLON {printf(":");} T_NUMBER ;
    
divident: T_DIVIDENT {printf("\t\t\t\"divident\"");} T_COLON {printf(":");} T_FLOATNUM;

winners:T_WINNERS {printf("\t\t\t\"winners\"");} T_COLON {printf(":");} T_NUMBER;

distributed: T_DISTRIBUTED {printf("\t\t\t\"distributed\"");} T_COLON {printf(":");} T_FLOATNUM;

jackpot: T_JACKPOT {printf("\t\t\t\"jackpot\"");} T_COLON {printf(":");} T_FLOATNUM;

fixed: T_FIXED {printf("\t\t\t\"fixed\"");} T_COLON {printf(":");} T_FLOATNUM;

categoryType: T_CATEGORYTYPE {printf("\t\t\t\"categoryType\"");} T_COLON {printf(":");} T_NUMBER;

gameType: T_GAMETYPE {printf("\t\t\t\"gameType\"");} T_COLON {printf(":");} T_JSTRING;

minimumDistributed: T_MINIMUMDISTRIBUTED {printf("\t\t\t\"minimumDistributed\"");} T_COLON {printf(":");} T_FLOATNUM;

wagerStatistics: T_WAGERSTATISTICS{printf("\t\t\"wagerStatistics\"");} T_COLON {printf(":");} T_LBRACE {printf("{\n");} wagerStatistics_info T_RBRACE T_RBRACE T_COMMA {printf("\n\t\t }\n\t},\n");};
wagerStatistics_run: T_WAGERSTATISTICS{printf("\t\t\"wagerStatistics\"");} T_COLON {printf(":");} T_LBRACE {printf("{\n");} wagerStatistics_info T_RBRACE T_RBRACE {printf("\n\t\t }\n\t}\n");};

wagerStatistics_info: T_COLUMNS {printf("\t\t\t\"columns\"");} T_COLON {printf(":");} T_NUMBER T_COMMA{printf(",\n");}
         T_WAGERS {printf("\t\t\t\"wagers\"");} T_COLON {printf(":");} T_NUMBER T_COMMA{printf(",\n");}
         T_ADDON {printf("\t\t\t\"addOn\"");} T_COLON {printf(":");} T_LBRACK T_RBRACK {printf("[]");}
;


			
%%

int main(int argc, char* argv[]){

	int token;
	if(argc>1){
		yyin = fopen(argv[1], "r"); 
		if (yyin == NULL){
			perror ("Error opening file");
			return -1;
		}
	}
	
	yyparse();
	printf("\n\n\t!!! Json file has been read correctly !!!\n\n");

	fclose(yyin);
	return 0;
	
}

void yyerror(const char *s) {
	printf(" Error found at line: %d\n",yylineno); 
	exit(1);

}


void checkgame_id(char* a){
	
	
    if (atoi(a)== 1100 || atoi(a)==1110|| atoi(a)==2100|| atoi(a)==2101||atoi(a)==5103|| atoi(a)==5104|| atoi(a)==5106)
    	{}
    else{
      printf("\n\n !!! Error (line %i): Invalid GameID !!!\n", yylineno);
      exit(EXIT_FAILURE);
      }

}

void numbers_in_list(char* b){
	counter++;
	if(atoi(b)<1 | atoi(b)>45){
		printf("\n\n Error: The value of the number is out of range !!! (line %i)\n\n", yylineno);
		exit(EXIT_FAILURE);
	}
	
}

void number_of_numbers(int c){
	if( c!=5 ){
		printf("\n\n !!! Error: There must be 5 winning numbers. Here are: %i !!! (line %i)\n\n",counter, yylineno);
		exit(EXIT_FAILURE);	
	}
	

}




