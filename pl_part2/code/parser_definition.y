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

definition:
  undirected_definition
  | directed_definition 
  | ID LBRACE un_graph RBRACE {yyerror("Specify the type of graph: directed or undirected");}
  ;

undirected_definition:
    UNDIRECTEDGRAPH ID LBRACE un_graph RBRACE
    | UNDIRECTEDGRAPH ID LBRACE un_graph {yyerror("There is an unmatched brace");}
    ;

directed_definition:
  DIRECTEDGRAPH ID LBRACE di_graph RBRACE
  | DIRECTEDGRAPH ID LBRACE di_graph {yyerror("There is an unmatched brace");}
  ;

un_graph:
  un_unit_list;
  
di_graph:
  di_unit_list;

un_unit_list:
  un_unit un_unit_list|;
  
di_unit_list:
  di_unit di_unit_list |;

un_unit:
  pre_un_unit ENDSTMT 
  | pre_un_unit {yyerror("expected ';'");}
  | vertex_definition
  ;

pre_un_unit:
  VERTEX id_list 
  | edge_definition_un
  | vertex_edge_property_addition_un 
  ;

di_unit:
  pre_di_unit ENDSTMT
  | pre_di_unit {yyerror("expected ';'");}
  |  vertex_definition
  ;

pre_di_unit:
  VERTEX id_list
  | edge_definition_di
  | vertex_edge_property_addition_di 
  ;

vertex_edge_property_addition_di:
  ID DOT STRING ASSIGN expr
  | LPARAM ID arrow ID RPARAM DOT STRING ASSIGN expr 
  ;

vertex_edge_property_addition_un:
  ID DOT STRING ASSIGN expr
  | LPARAM ID LINE ID RPARAM DOT STRING ASSIGN expr 
  ;

edge_definition_un:
  EDGE ID LBRACE property_list RBRACE
  | EDGE id_list
  | EDGE ID ASSIGN ID LINE ID
  | ID id_tail
  | ID ASSIGN ID LINE ID
  ;

edge_definition_di:
  EDGE ID LBRACE property_list RBRACE
  | EDGE id_list
  | ID ASSIGN ID arrow ID
  ;

id_tail:
  LINE ID id_tail | ;

vertex_definition:
    VERTEX ID LBRACE property_list RBRACE
    | ID LBRACE property_list RBRACE {yyerror("You have to specify the type of definition: edge or vertex");} 
    ;

id_list:
  ID id_list_tail ;

id_list_tail:
  COMMA ID id_list_tail  |  ;

property_list:
  property property_list |  ;

property:
    STRING ASSIGN expr ENDSTMT
    | ID ASSIGN expr ENDSTMT {yyerror("String is expected as property name");} 
    ;
arrow:
    LEFTARROW 
    | RIGHTARROW
    | DOUBLEARROW
    ;

expr:
  ID 
  | STRING 
  | INT 
  | FLOAT 
  | BOOL 
  | SET LPARAM LBRACKET set_elements RBRACKET RPARAM
  ;

set_elements:
  expr set_elements_tails;

set_elements_tails:
  COMMA expr set_elements_tails |;
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




