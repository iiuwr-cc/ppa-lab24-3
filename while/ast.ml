(*-----------------------------------------------------------------------------
 * Principles of Program Analysis - Laboratory
 *    University of Wroclaw, Institute of Computer Science
 *---------------------------------------------------------------------------*)

open Common.Ast

type arith_binop = BINOP_Add | BINOP_Sub | BINOP_Mul | BINOP_Div
type arith_unop = UNOP_Neg
type bool_binop = BINOP_Or | BINOP_And
type bool_unop = UNOP_Not
type relop = RELOP_Eq | RELOP_Ne | RELOP_Lt | RELOP_Le | RELOP_Gt | RELOP_Ge

type arith_expression =
  | AEXPR_Int of { value : int }
  | AEXPR_Var of { var : id }
  | AEXPR_BinOp of {
      op : arith_binop;
      lhs : arith_expression;
      rhs : arith_expression;
    }
  | AEXPR_UnOp of { op : arith_unop; sub : arith_expression }

let is_trivial_arith_expression = function
  | AEXPR_Int _ -> true
  | AEXPR_Var _ -> true
  | _ -> false

let is_non_trivial_arith_expression e = not @@ is_trivial_arith_expression e

module AExprSet = Set.Make (struct
  type t = arith_expression

  let compare = compare
end)

let rec _aexprs_of_arith_expression aux = function
  | AEXPR_Int _ as e -> AExprSet.add e aux
  | AEXPR_Var _ as e -> AExprSet.add e aux
  | AEXPR_UnOp { sub; _ } as e ->
      let aux = AExprSet.add e aux in
      _aexprs_of_arith_expression aux sub
  | AEXPR_BinOp { lhs; rhs; _ } as e ->
      let aux = AExprSet.add e aux in
      let aux = _aexprs_of_arith_expression aux lhs in
      let aux = _aexprs_of_arith_expression aux rhs in
      aux

let aexprs_of_arith_expression_set e =
  _aexprs_of_arith_expression AExprSet.empty e

let aexprs_of_arith_expression_seq e =
  AExprSet.to_seq @@ aexprs_of_arith_expression_set e

let aexprs_of_arith_expression_list e =
  List.of_seq @@ aexprs_of_arith_expression_seq e

type bool_expression =
  | BEXPR_Bool of { loc : location; value : bool }
  | BEXPR_RelOp of {
      op : relop;
      lhs : arith_expression;
      rhs : arith_expression;
    }
  | BEXPR_BinOp of {
      op : bool_binop;
      lhs : bool_expression;
      rhs : bool_expression;
    }
  | BEXPR_UnOp of { op : bool_unop; sub : bool_expression }

let rec _vars_of_arith_expression aux = function
  | AEXPR_Int _ -> aux
  | AEXPR_Var { var; _ } -> IdSet.add var aux
  | AEXPR_BinOp { lhs; rhs; _ } ->
      let aux = _vars_of_arith_expression aux lhs in
      let aux = _vars_of_arith_expression aux rhs in
      aux
  | AEXPR_UnOp { sub; _ } -> _vars_of_arith_expression aux sub

let vars_of_arith_expression_set expr =
  _vars_of_arith_expression IdSet.empty expr

let vars_of_arith_expression_seq expr =
  IdSet.to_seq @@ vars_of_arith_expression_set expr

let vars_of_arith_expression_list expr =
  List.of_seq @@ vars_of_arith_expression_seq expr

let rec _vars_of_bool_expression aux = function
  | BEXPR_Bool _ -> aux
  | BEXPR_BinOp { lhs; rhs; _ } ->
      let aux = _vars_of_bool_expression aux lhs in
      let aux = _vars_of_bool_expression aux rhs in
      aux
  | BEXPR_UnOp { sub; _ } -> _vars_of_bool_expression aux sub
  | BEXPR_RelOp { lhs; rhs; _ } ->
      let aux = _vars_of_arith_expression aux lhs in
      let aux = _vars_of_arith_expression aux rhs in
      aux

let vars_of_bool_expression_set expr = _vars_of_bool_expression IdSet.empty expr

let vars_of_bool_expression_seq expr =
  IdSet.to_seq @@ vars_of_bool_expression_set expr

let vars_of_bool_expression_list expr =
  List.of_seq @@ vars_of_bool_expression_seq expr

let rec _aexprs_of_bool_expression aux = function
  | BEXPR_Bool _ -> aux
  | BEXPR_UnOp { sub; _ } -> _aexprs_of_bool_expression aux sub
  | BEXPR_BinOp { lhs; rhs; _ } ->
      let aux = _aexprs_of_bool_expression aux lhs in
      let aux = _aexprs_of_bool_expression aux rhs in
      aux
  | BEXPR_RelOp { lhs; rhs; _ } ->
      let aux = _aexprs_of_arith_expression aux lhs in
      let aux = _aexprs_of_arith_expression aux rhs in
      aux

let aexprs_of_bool_expression_set e =
  _aexprs_of_bool_expression AExprSet.empty e

let aexprs_of_bool_expression_seq e =
  AExprSet.to_seq @@ aexprs_of_bool_expression_set e

let aexprs_of_bool_expression_list e =
  List.of_seq @@ aexprs_of_bool_expression_seq e

type struct_statement =
  | SSTMT_Assign of { lhs : id; rhs : arith_expression; loc : location }
  | SSTMT_If of {
      cond : bool_expression;
      then_branch : struct_statement list;
      else_branch : struct_statement list option;
      loc : location;
    }
  | SSTMT_While of {
      cond : bool_expression;
      body : struct_statement list;
      loc : location;
    }
  | SSTMT_Skip of { loc : location }
  | SSTMT_Break of { loc : location }
  | SSTMT_Continue of { loc : location }

type seq_statement =
  | STMT_Assign of { lhs : id; rhs : arith_expression; loc : location }
  | STMT_IfGoto of { cond : bool_expression; target : label; loc : location }
  | STMT_Goto of { target : label; loc : location }
  | STMT_Skip of { loc : location }

let _vars_of_seq_statement aux = function
  | STMT_Assign { lhs; rhs; _ } ->
      let aux = IdSet.add lhs aux in
      let aux = _vars_of_arith_expression aux rhs in
      aux
  | STMT_IfGoto { cond; _ } ->
      let aux = _vars_of_bool_expression aux cond in
      aux
  | STMT_Goto _ -> aux
  | STMT_Skip _ -> aux

let _aexprs_of_seq_statement aux = function
  | STMT_Assign { rhs; _ } ->
      let aux = _aexprs_of_arith_expression aux rhs in
      aux
  | STMT_IfGoto { cond; _ } ->
      let aux = _aexprs_of_bool_expression aux cond in
      aux
  | STMT_Goto _ -> aux
  | STMT_Skip _ -> aux

type labeled_statement = label * seq_statement
type labeled_block = labeled_statement list

let vars_of_labeled_block_set xs =
  let f vs (_, s) = _vars_of_seq_statement vs s in
  List.fold_left f IdSet.empty xs

let vars_of_labeled_block_seq xs = IdSet.to_seq @@ vars_of_labeled_block_set xs
let vars_of_labeled_block_list xs = List.of_seq @@ vars_of_labeled_block_seq xs

let aexprs_of_labeled_block_set xs =
  let f vs (_, s) = _aexprs_of_seq_statement vs s in
  List.fold_left f AExprSet.empty xs

let aexprs_of_labeled_block_seq xs =
  AExprSet.to_seq @@ aexprs_of_labeled_block_set xs

let aexprs_of_labeled_block_list xs =
  List.of_seq @@ aexprs_of_labeled_block_seq xs

type structured_block = struct_statement list
type program = Labeled of labeled_block | Structured of structured_block
