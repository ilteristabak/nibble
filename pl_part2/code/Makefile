all: query_parser

query_parser: parser_real.y lexer.l
	yacc --report=state -d parser_real.y
	flex lexer.l
	g++ y.tab.c lex.yy.c -o query_parser
		
clean:
	rm -f lex.yy.c y.tab.h y.tab.c query_parser y.output