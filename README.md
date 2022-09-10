# JsonCompilerOPAP
Compiler for json files from OPAP api


Excecuting the compiler (terminal): 

1) bison -d comp.y 
2) flex comp.l \n
3) gcc -o run lex.yy.c comp.tab.c -lfl
4) ./run last_result.json


