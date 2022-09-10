# JsonCompilerOPAP
Compiler for json files from OPAP api


Excecuting the compiler(terminal): 

bison -d comp.y
flex comp.l
gcc -o run lex.yy.c comp.tab.c -lfl
./run last_result.json


