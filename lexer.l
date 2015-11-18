%{
#include <stdlib.h>
%}

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
APOST '
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
ALTERNATION \|
EQUAL ==


%%
{DIRECTEDGRAPH} printf(" DIRECTEDGRAPH ");
{UNDIRECTEDGRAPH} printf("UNDIRECTEDGRAPH ");
{VERTEX} printf("VERTEX ");
{EDGE} printf("EDGE ");
{LINE} printf("LINE ");
{LEFTARROW} printf("LEFTARROW ");
{RIGHTARROW} printf("RIGHTARROW ");
{DOUBLEARROW} printf("DOUBLEARROW ");
{QUESTION} printf("QUESTION ");
{AND} printf("AND ");
{OR} printf("OR ");
{DOT} printf("DOT ");
{SPACE} ;
{COMMENT} ;
{COMMA} printf("COMMA ");
{APOST} printf("APOST ");
{NEWLINE} ;
{ENDSTMT} printf("ENDSTMT ");
{ASSIGN} printf("ASSIGN ");
{NOT} printf("NOT ");
{LTE} printf("LTE ");
{GTE} printf("GTE ");
{LT} printf("LT ");
{GT} printf("GT ");
{POW} printf("POW ");
{LBRACE} printf("LBRACE ");
{RBRACE} printf("RBRACE ");
{PLUS} printf("PLUS ");
{MINUS} printf("MINUS ");
{MUL} printf("MUL ");
{DIV} printf("DIV ");
{LPARAM} printf("LPARAM ");
{RPARAM} printf("RPARAM ");
{LBRACKET} printf("LBRACKET ");
{RBRACKET} printf("RBRACKET ");
{STRING} printf("STRING(%s)",yytext);
{BOOL} printf("BOOL(%s) ",yytext);
{INT} printf("INT(%s) ",yytext);
{FLOAT} printf("FLOAT(%s) ",yytext);
{ID} printf("ID(%s) ",yytext);
{ALTERNATION} printf("ALTERNATION ");
{EQUAL} printf("EQUAL ");




%%
int yywrap()
{
	return 1;
}
int main()
{
/*
*/
	yylex();
	return 0;
}
