CC     = g++
CXX    = g++
LEX    = flex
PROG   = lexer

all: $(PROG)

lex.yy.c: $(PROG).l
	$(LEX) $(PROG).l  

$(PROG): lex.yy.c
	$(CXX) -o $(PROG) lex.yy.c -ll

test: input
	cat input | ./$(PROG)

clean:
	-rm -f lex.yy.c
	-rm -f $(PROG)

