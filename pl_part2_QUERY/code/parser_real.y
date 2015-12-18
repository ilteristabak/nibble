// Define the tokens


%token SPACE
%token ASSIGN
%token PLUS
%token RIGHTARROW
%token LEFTARROW
%token DOUBLEARROW
%token LINE
%token MINUS
%token MUL
%token DIV
%token COMMA
%token DOT
%token LT
%token GT
%token LTE
%token GTE
%token NOT
%token APOST
%token POW
%token LPARAM
%token RPARAM
%token LBRACE
%token RBRACE
%token LBRACKET
%token RBRACKET
%token DIGIT
%token LETTER
%token NEWLINE
%token NONSTAR
%token NONSTARNONDIV
%token NONNEWLINE
%token UNDERSCORE
%token STRING
%token BOOL
%token SET
%token ID
%token INT
%token FLOAT
%token ENDSTMT
%token COMMENT
%token DIRECTEDGRAPH
%token UNDIRECTEDGRAPH
%token VERTEX
%token EDGE
%token QUESTION
%token AND
%token OR
%token ALTERNATION
%token EQUAL


// Define the union that can hold different values for the tokens
 
%union 
{
  char * string;
  int integer;
}

// Define the token value types

%type <integer> INT
%type <string> ID
// define associativity of operations

//
%nonassoc LPARAM RPARAM
%left PLUS MINUS // the order defines precedence, 
%left MUL DIV // so * and / has higher precedence than + and -
%nonassoc NEG  // negation--unary minus has the highest precedence, and is non-associative

%{ 
  #include <iostream> 
  #include <string>
  using namespace std;
  // forward declarations
  extern int yylineno;
  void yyerror(string);
  int yylex(void);
  int numoferr;
  
%}

%%

program:
	  statement program
	| statement
	;

statement:
	  assignment ENDSTMT
	| query_execution ENDSTMT
	; 

assignment:
	  ID ASSIGN INT
	| ID ASSIGN query_expr
	;

query_execution:
	ID QUESTION query_expr
	| ID NOT query_expr {yyerror("Use ? to execute a query expression");}
	| QUESTION query_expr {yyerror("Required a graph name before ?");}
	;

query_expr:
	  query_expr ALTERNATION query_term
	| query_term
	;

query_term:
	  query_term query_factor
	| query_factor
	;

query_factor:
	  query_factor MUL
	| query_expo
	;

query_expo:
      LPARAM query_expr RPARAM
	| query_unit
	| ID
	;

query_unit:
	  edge_filter
	| vertex_filter
	;

edge_filter:
	  LT predicate GT;
	
vertex_filter:
	  LBRACKET predicate RBRACKET;

predicate:
	  BOOL
	| ID ASSIGN property_name
	| property_name operator property_value_expr
	| property_name arithmetic property_value_expr {yyerror("Wrong usage of arithmetic operation");}
	| ID operator property_value_expr {yyerror("Property names should be in \" \"");}
	|  {yyerror("Required a boolean expression or assignment");} 	 	
	;

property_name:
	  STRING
	| ID LPARAM STRING RPARAM
	;

property_value_expr:
	  property_value_expr arithmetic property_value_term
	| property_value_term
	;
property_value_term:
	  LPARAM property_value_expr RPARAM
	| STRING
	| INT
	| FLOAT
	| ID
	;
arithmetic:
	  PLUS
	| MINUS
	| DIV
	| MUL
	;
operator:
	  EQUAL
	| LT
	| GT
	| LTE
	| GTE
	;
%%

// report errors
extern int yylineno;
void yyerror(string s) 
{
	numoferr++;
	cout << "error: " << s << " at line " << yylineno <<  endl;
}
int main()
{
	numoferr=0;
	yyparse();
	if(numoferr>0) {
		cout << "Parsing completed with " << numoferr << " errors" <<endl;
	} else {
		cout << "Successfully parsed" <<endl;
	}
	return 0;
}

