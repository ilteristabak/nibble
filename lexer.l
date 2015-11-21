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
{DIRECTEDGRAPH} printf(" DIRECTEDGRAPH(%s) ",yytext);
{UNDIRECTEDGRAPH} printf("UNDIRECTEDGRAPH(%s) ",yytext);
{VERTEX} printf("VERTEX(%s) ",yytext);
{EDGE} printf("EDGE(%s) ",yytext);
{LINE} printf("LINE(%s) ",yytext);
{LEFTARROW} printf("LEFTARROW(%s) ",yytext);
{RIGHTARROW} printf("RIGHTARROW(%s) ",yytext);
{DOUBLEARROW} printf("DOUBLEARROW(%s) ",yytext);
{QUESTION} printf("QUESTION(%s) ",yytext);
{AND} printf("AND(%s) ",yytext);
{OR} printf("OR(%s) ",yytext);
{DOT} printf("DOT(%s) ",yytext);
{SPACE} ;
{COMMENT} ;
{COMMA} printf("COMMA(%s) ",yytext);
{APOST} printf("APOST(%s) ",yytext);
{NEWLINE} ;
{ENDSTMT} printf("ENDSTMT(%s) ",yytext);
{ASSIGN} printf("ASSIGN(%s) ",yytext);
{NOT} printf("NOT(%s) ",yytext);
{LTE} printf("LTE(%s) ",yytext);
{GTE} printf("GTE(%s) ",yytext);
{LT} printf("LT(%s) ",yytext);
{GT} printf("GT(%s) ",yytext);
{POW} printf("POW(%s) ",yytext);
{LBRACE} printf("LBRACE(%s) ",yytext);
{RBRACE} printf("RBRACE(%s) ",yytext);
{PLUS} printf("PLUS(%s) ",yytext);
{MINUS} printf("MINUS(%s) ",yytext);
{MUL} printf("MUL(%s) ",yytext);
{DIV} printf("DIV(%s) ",yytext);
{LPARAM} printf("LPARAM(%s) ",yytext);
{RPARAM} printf("RPARAM(%s) ",yytext);
{LBRACKET} printf("LBRACKET(%s) ",yytext);
{RBRACKET} printf("RBRACKET(%s) ",yytext);
{STRING} printf("STRING(%s)",yytext);
{BOOL} printf("BOOL(%s) ",yytext);
{INT} printf("INT(%s) ",yytext);
{FLOAT} printf("FLOAT(%s) ",yytext);
{ID} printf("ID(%s) ",yytext);
{ALTERNATION} printf("ALTERNATION(%s) ",yytext);
{EQUAL} printf("EQUAL(%s) ",yytext);




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
