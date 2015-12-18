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
{DIRECTEDGRAPH} return DIRECTEDGRAPH;
{UNDIRECTEDGRAPH} return UNDIRECTEDGRAPH;
{VERTEX} return VERTEX;
{EDGE} return EDGE;
{LINE} return LINE;
{LEFTARROW} return LEFTARROW;
{RIGHTARROW} return RIGHTARROW;
{DOUBLEARROW} return DOUBLEARROW;
{QUESTION} return QUESTION;
{AND} return AND;
{OR} return OR;
{DOT} return DOT;
{SPACE} ;
{COMMENT} ;
{COMMA} return COMMA;
{APOST} return APOST;
{NEWLINE} ;
{ENDSTMT} return ENDSTMT;
{ASSIGN} return ASSIGN;
{NOT} return NOT;
{LTE} return LTE;
{GTE} return GTE;
{LT} return LT;
{GT} return GT;
{POW} return POW;
{LBRACE} return LBRACE;
{RBRACE} return RBRACE;
{PLUS} return PLUS;
{MINUS} return MINUS;
{MUL} return MUL;
{DIV} return DIV;
{LPARAM} return LPARAM;
{RPARAM} return RPARAM;
{LBRACKET} return LBRACKET;
{RBRACKET} return RBRACKET;
{STRING} return STRING;
{BOOL} return BOOL;
{INT} return INT;
{FLOAT} return FLOAT;
{ID} return ID;
{ALTERNATION} return ALTERNATION;
{EQUAL} return EQUAL;




%%
int yywrap()
{
	return 1;
}
