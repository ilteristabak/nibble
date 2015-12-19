all: query_parser

definition_parser: parser_definition.y lexer.l
	yacc --report=state -d parser_definition.y
	flex lexer.l
	g++ y.tab.c lex.yy.c -o definition_parser

query_parser: parser_query.y lexer.l
	yacc --report=state -d parser_query.y
	flex lexer.l
	g++ y.tab.c lex.yy.c -o query_parser
		
clean:
	rm -f lex.yy.c y.tab.h y.tab.c query_parser definition_parser y.output 