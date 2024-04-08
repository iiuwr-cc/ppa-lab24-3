(*-----------------------------------------------------------------------------
 * Principles of Program Analysis - Laboratory
 *    University of Wroclaw, Institute of Computer Science
 *---------------------------------------------------------------------------*)
open Common.Ast
open Ast

let string_of_arith_binop = function
  | BINOP_Add -> "+"
  | BINOP_Sub -> "-"
  | BINOP_Mul -> "*"
  | BINOP_Div -> "/"

let string_of_bool_binop = function BINOP_And -> "&&" | BINOP_Or -> "||"
let string_of_arith_unop = function UNOP_Neg -> "-"
let string_of_bool_unop = function UNOP_Not -> "!"

let string_of_relop = function
  | RELOP_Eq -> "=="
  | RELOP_Ne -> "!="
  | RELOP_Lt -> "<"
  | RELOP_Le -> "<="
  | RELOP_Gt -> ">"
  | RELOP_Ge -> ">="

let prio_of_arith_binop = function
  | BINOP_Add -> 10
  | BINOP_Sub -> 10
  | BINOP_Mul -> 20
  | BINOP_Div -> 20

let prio_of_bool_binop = function BINOP_And -> 20 | BINOP_Or -> 10
let prio_of_arith_unop = function UNOP_Neg -> 30
let prio_of_bool_unop = function UNOP_Not -> 30

let prio_of_arith_expression = function
  | AEXPR_Int _ | AEXPR_Var _ -> 100
  | AEXPR_BinOp { op; _ } -> prio_of_arith_binop op
  | AEXPR_UnOp _ -> 30

let prio_of_bool_expression = function
  | BEXPR_Bool _ -> 100
  | BEXPR_BinOp { op; _ } -> prio_of_bool_binop op
  | BEXPR_UnOp _ -> 30
  | BEXPR_RelOp _ -> 5

let bracket_if my_prio other_prio str =
  if other_prio < my_prio then Format.sprintf "(%s)" str else str

let rec string_of_arith_expression = function
  | AEXPR_Int { value; _ } -> string_of_int value
  | AEXPR_Var { var; _ } -> string_of_id var
  | AEXPR_BinOp { lhs; op; rhs; _ } ->
      let my_prio = prio_of_arith_binop op in
      let lhs_prio = prio_of_arith_expression lhs in
      let rhs_prio = pred @@ prio_of_arith_expression rhs in
      String.concat " "
        [
          bracket_if my_prio lhs_prio @@ string_of_arith_expression lhs;
          string_of_arith_binop op;
          bracket_if my_prio rhs_prio @@ string_of_arith_expression rhs;
        ]
  | _ -> "?"

let string_of_arith_expression_set m =
  AExprSet.to_seq m
  |> Common.To_string.set_seq_to_string string_of_arith_expression

let rec string_of_bool_expression = function
  | BEXPR_Bool { value; _ } -> string_of_bool value
  | BEXPR_RelOp { lhs; op; rhs; _ } ->
      String.concat " "
        [
          string_of_arith_expression lhs;
          string_of_relop op;
          string_of_arith_expression rhs;
        ]
  | BEXPR_BinOp { lhs; op; rhs; _ } ->
      let my_prio = prio_of_bool_binop op in
      let lhs_prio = prio_of_bool_expression lhs in
      let rhs_prio = pred @@ prio_of_bool_expression rhs in
      String.concat " "
        [
          bracket_if my_prio lhs_prio @@ string_of_bool_expression lhs;
          string_of_bool_binop op;
          bracket_if my_prio rhs_prio @@ string_of_bool_expression rhs;
        ]
  | BEXPR_UnOp { sub; op; _ } ->
      let my_prio = prio_of_bool_unop op in
      let sub_prio = prio_of_bool_expression sub in
      String.concat " "
        [
          string_of_bool_unop op;
          bracket_if my_prio sub_prio @@ string_of_bool_expression sub;
        ]

let string_of_seq_statement = function
  | STMT_Skip _ -> "skip"
  | STMT_Goto { target; _ } -> Format.sprintf "goto %s" (string_of_label target)
  | STMT_Assign { lhs; rhs; _ } ->
      Format.sprintf "%s = %s" (string_of_id lhs)
        (string_of_arith_expression rhs)
  | STMT_IfGoto { target; cond; _ } ->
      Format.sprintf "if %s goto %s"
        (string_of_bool_expression cond)
        (string_of_label target)

let string_of_labeled_statement = function
  | l, s ->
      Format.sprintf "%s: %s;" (string_of_label l) (string_of_seq_statement s)

let string_of_labeled_program = List.map string_of_labeled_statement
