%{
(* ----------------------------------------------------------------------------
 * Principles of Program Analysis - Labolatory
 *    University of Wroclaw, Institute of Computer Science
 *---------------------------------------------------------------------------*)
open Common.Ast
open Ast

let mkABinOp op lhs rhs = AEXPR_BinOp {op=op; lhs=lhs; rhs=rhs } 
let mkBBinOp op lhs rhs = BEXPR_BinOp {op=op; lhs=lhs; rhs=rhs } 
let mkBRelOp op lhs rhs = BEXPR_RelOp {op=op; lhs=lhs; rhs=rhs } 
let mkAUnOp op sub = AEXPR_UnOp {op=op; sub=sub } 
let mkBUnOp op sub = BEXPR_UnOp {op=op; sub=sub } 

%}

%type <Ast.program> file

%token EOF
%token <string> IDENTIFIER
%token <int> INT
%token <int> LABEL
%start file 

%token REL_EQ REL_LT REL_LE REL_GE REL_GT REL_NE
%token OP_ADD OP_SUB OP_DIV OP_MUL OP_NOT OP_AND OP_OR
%token IF WHILE ELSE BREAK CONTINUE GOTO SKIP
%token OP_ASSIGN
%token COLON SEMICOLON LPARENT RPARENT CURLY_LPARENT CURLY_RPARENT
%token TRUE FALSE

%%

/**********************************************
 * ENTRY
 */

file:
    | program EOF
    { $1 }


program:
    | labeled
    { Labeled $1 }

    | structured
    { Structured $1 }

/**********************************************
 * Labeled
 */

labeled:
    | many1(labeled_statement)
    { $1 }

labeled_statement:
    | label COLON instruction_statement SEMICOLON
    { ($1, $3) }

instruction_statement:
    | id OP_ASSIGN arith_expression
    { STMT_Assign {loc=mkLoc $startpos; lhs=$1; rhs=$3}}

    | GOTO label
    { STMT_Goto {loc=mkLoc $startpos; target=$2} }

    | IF bool_expression GOTO label
    { STMT_IfGoto {loc=mkLoc $startpos; cond=$2; target=$4  }}

    | SKIP
    { STMT_Skip {loc=mkLoc $startpos} }

/**********************************************
 * Structured statement
 */

 structured:
    | many(simple_struct_statement)
    { $1 }

simple_struct_statement:
    | id OP_ASSIGN arith_expression SEMICOLON
    { SSTMT_Assign {loc=mkLoc $startpos; lhs=$1; rhs=$3}}

    | SKIP SEMICOLON
    { SSTMT_Skip {loc=mkLoc $startpos} }

    | BREAK SEMICOLON
    { SSTMT_Break {loc=mkLoc $startpos} }

    | CONTINUE SEMICOLON
    { SSTMT_Continue {loc=mkLoc $startpos} }

    | WHILE bool_expression struct_block
    { SSTMT_While {loc=mkLoc $startpos; cond=$2; body=$3 } }

    | IF bool_expression struct_block
    { SSTMT_If {loc=mkLoc $startpos; cond=$2; then_branch=$3; else_branch=None} }

    | IF bool_expression struct_block ELSE struct_block
    { SSTMT_If {loc=mkLoc $startpos; cond=$2; then_branch=$3; else_branch=Some $5} }

struct_block:
    | CURLY_LPARENT many(simple_struct_statement)
      CURLY_RPARENT
    { $2 } 


/**********************************************
 * Boolean expressions
 */

and_binop:
    | OP_AND { mkBBinOp BINOP_And }

or_binop:
    | OP_OR { mkBBinOp BINOP_Or }

bool_unop:
    | OP_NOT { mkBUnOp UNOP_Not }

bool_expression:
    | or_bool_expression { $1 }

or_bool_expression:
    | left_assoc(or_binop, and_bool_expression) { $1 } 

and_bool_expression:
    | left_assoc(and_binop, un_bool_expression) { $1 }

un_bool_expression:
    | un_noassoc(bool_unop, rel_bool_expression) { $1 } 

relop:
    | REL_EQ { mkBRelOp RELOP_Eq }
    | REL_NE { mkBRelOp RELOP_Ne }
    | REL_LT { mkBRelOp RELOP_Lt }
    | REL_LE { mkBRelOp RELOP_Le }
    | REL_GT { mkBRelOp RELOP_Gt }
    | REL_GE { mkBRelOp RELOP_Ge }

rel_bool_expression:
    | TRUE
    { BEXPR_Bool {loc=mkLoc $startpos; value=true }}

    | FALSE
    { BEXPR_Bool {loc=mkLoc $startpos; value=false }}

    | brackets(LPARENT, RPARENT, bool_expression)
    { $1 }

    | bin_noassoc(relop, arith_expression)
    { $1 }

/**********************************************
 * Arithmetic expressions
 */

addsub_binop:
    | OP_ADD { mkABinOp BINOP_Add }
    | OP_SUB { mkABinOp BINOP_Sub }

muldiv_binop:
    | OP_DIV { mkABinOp BINOP_Div }
    | OP_MUL { mkABinOp BINOP_Mul }

arith_unop:
    | OP_SUB { mkAUnOp UNOP_Neg }

arith_expression:
    | addsub_arith_expression { $1 }

addsub_arith_expression:
    | left_assoc(addsub_binop, muldiv_arith_expression) { $1 } 

muldiv_arith_expression:
    | left_assoc(muldiv_binop, un_arith_expression) { $1 }

un_arith_expression:
    | un_noassoc(arith_unop, atom_arith_expression) { $1 } 

atom_arith_expression:
    | INT
    { AEXPR_Int { value = $1} }

    | id
    { AEXPR_Var { var = $1 }}

    | brackets(LPARENT, RPARENT, arith_expression)
    { $1 }

/**********************************************
 * lexical 
 */

id:
    | IDENTIFIER
    { Id $1 }

label:
    | LABEL
    { Label $1 }

/**********************************************
 * Macros
 */

left_assoc(BINOP, NEXT):
    | left_assoc(BINOP, NEXT) BINOP NEXT
    { ($2) $1 $3 }

    | NEXT
    { $1 }

un_noassoc(UNOP, NEXT):
    | UNOP NEXT { ($1) $2 }
    | NEXT { $1 }

bin_noassoc(BINOP, NEXT):
    | NEXT BINOP NEXT
    { ($2) $1 $3 }

opt(P):
    | { None }
    | P { Some $1 }

raw_many(P):
    | 
    { [] }

    | raw_many(P) P
    { $2::$1 }

brackets(L, R, P):
  | L P R { $2 }

many(P):
    | raw_many(P)
    { List.rev $1 }

many1(P):
    | P many(P)
    { $1 :: $2 }

prefix(S,P):
    | S P
    { $2 }

suffix(P,S):
    | P S
    { $1 }

manySep(S,P):
    | 
    { [] }

    | manySep1(S, P)
    { $1 }

manySep1(S,P):
    | P many(prefix(S,P))
    { $1 :: $2 }
