%{
#include<iostream>
#include "y.tab.h"
using namespace std;
int yyparse();
%}
%option yylineno

SPACE [ \t]+
ASSIGN =
PLUS \+
RIGHTARROW ->
LEFTARROW <-
DOUBLEARROW <->
LINE --
MINUS -
MUL \*
DIV \/
COMMA ,
DOT \.
LT <
GT >
LTE <=
GTE >=
NOT !
POW \^
LPARAM \(
RPARAM \)
LBRACE \{
RBRACE \}
LBRACKET \[
RBRACKET \]
DIGIT [0-9]
LETTER [a-zA-Z]
NEWLINE \n
NONSTAR [^\*]
NONSTARNONDIV [^\*/]
NONNEWLINE [^\n]
UNDERSCORE _
STRING \"([^\\\"]|\\\\|\\\"|\\t|\\n)*\"
BOOL true|false
ID ({LETTER}|{UNDERSCORE})({LETTER}|{DIGIT}|{UNDERSCORE})*
INT ({MINUS}|{PLUS})?{DIGIT}+
FLOAT {INT}"."{DIGIT}+
ENDSTMT ;
COMMENT {DIV}{DIV}{NONNEWLINE}*{NEWLINE}|{DIV}\*({NONSTAR}|\*+{NONSTARNONDIV})*\*+{DIV}
DIRECTEDGRAPH digraph
UNDIRECTEDGRAPH ungraph
VERTEX vertex
EDGE edge
QUESTION \?
AND &&
OR \|\|

// TODO 

int yywrap()
{
	return 1;
}
