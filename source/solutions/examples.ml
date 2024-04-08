(*-----------------------------------------------------------------------------
 * Principles of Program Analysis - Laboratory
 *    University of Wroclaw, Institute of Computer Science
 *---------------------------------------------------------------------------*)

(* This file contains implementation of basic analyses presented in the course
 * textbook. 
 *)

open Common.Ast
open While
open Analysis_registry
open Ast

(*-----------------------------------------------------------------------------
 * Reaching Definitions
 *---------------------------------------------------------------------------*)

module MFP_ReachingDefinitions = struct
  module ControlFlowGraphView = While.Cfg.ForwardControlFlowGraphView

  module Domain = Set.Make (struct
    type t = id * label option

    let compare = compare
  end)

  type domain = Domain.t

  let elt_to_string (id, labelopt) =
    match labelopt with
    | Some label ->
        Format.sprintf "(%s, %s)" (string_of_id id) (string_of_label label)
    | None -> Format.sprintf "(%s, ?)" (string_of_id id)

  let to_string xs =
    Domain.to_seq xs |> Common.To_string.set_seq_to_string elt_to_string

  let bot _ _ = Domain.empty
  let join = Domain.union
  let less_or_equal = Domain.subset

  let extreme program _ =
    Ast.vars_of_labeled_block_seq program
    |> Seq.map (fun x -> (x, None))
    |> Domain.of_seq

  let kill input = function
    | STMT_Assign { lhs; _ } ->
        let pred (x, _) = x <> lhs in
        Domain.filter pred input
    | _ -> input

  let gen input label = function
    | STMT_Assign { lhs; _ } -> Domain.add (lhs, Some label) input
    | _ -> input

  let transfer input label stmt =
    let input = kill input stmt in
    gen input label stmt
end

module Handle_ReachingDefinition = RegisterAnalysis (struct
  module MonotoneFrameworkParameters = MFP_ReachingDefinitions

  let name = "reaching_definitions"
end)

(*-----------------------------------------------------------------------------
 * Reaching Definitions (different formulation)
 *---------------------------------------------------------------------------*)

module MFP_FunReachingDefinitions = struct
  module ControlFlowGraphView = While.Cfg.ForwardControlFlowGraphView

  type domain = LabelSet.t IdMap.t

  let to_string m =
    IdMap.to_seq m
    |> Common.To_string.map_seq_to_string string_of_id string_of_label_set

  let bot _ _ = IdMap.empty

  let join ma mb =
    let f _ opta optb =
      match (opta, optb) with
      | Some a, Some b -> Some (LabelSet.union a b)
      | Some a, None -> Some a
      | None, Some b -> Some b
      | None, None -> None
    in
    IdMap.merge f ma mb

  let less_or_equal ma mb =
    let check (k, a) =
      match IdMap.find_opt k mb with
      | Some b -> LabelSet.subset a b
      | None -> false
    in
    IdMap.to_seq ma |> Seq.map check |> Seq.fold_left ( && ) true

  let extreme program _ =
    let f acc var = IdMap.add var LabelSet.empty acc in
    Ast.vars_of_labeled_block_seq program |> Seq.fold_left f IdMap.empty

  let kill input = function
    | STMT_Assign { lhs; _ } -> IdMap.remove lhs input
    | _ -> input

  let gen input label = function
    | STMT_Assign { lhs; _ } -> IdMap.add lhs (LabelSet.singleton label) input
    | _ -> input

  let transfer input label stmt =
    let input = kill input stmt in
    gen input label stmt
end

module Handle_FunReachingDefinition = RegisterAnalysis (struct
  module MonotoneFrameworkParameters = MFP_FunReachingDefinitions

  let name = "fun_reaching_definitions"
end)

(*-----------------------------------------------------------------------------
 * Available Expressions
 *---------------------------------------------------------------------------*)

module MFP_AvailableExpressions = struct
  module ControlFlowGraphView = While.Cfg.ForwardControlFlowGraphView

  type domain = AExprSet.t

  let to_string = While.Printer.string_of_arith_expression_set

  let bot labeled_block _ =
    While.Ast.aexprs_of_labeled_block_set labeled_block
    |> AExprSet.filter is_non_trivial_arith_expression

  let extreme _ _ = AExprSet.empty
  let less_or_equal a b = AExprSet.subset b a
  let join = AExprSet.inter

  let kill input = function
    | STMT_Assign { lhs; _ } ->
        let pred aexpr =
          let vars = vars_of_arith_expression_set aexpr in
          not @@ IdSet.mem lhs vars
        in
        AExprSet.filter pred input
    | _ -> input

  let gen input _ = function
    | STMT_Assign { lhs; rhs; _ } ->
        let pred aexpr =
          let vars = vars_of_arith_expression_set aexpr in
          not @@ IdSet.mem lhs vars
        in
        let aexprs_of_rhs = aexprs_of_arith_expression_set rhs in
        let aexprs_to_add = AExprSet.filter pred aexprs_of_rhs in
        AExprSet.union aexprs_to_add input
    | STMT_IfGoto { cond; _ } ->
        let aexprs_to_add = aexprs_of_bool_expression_set cond in
        AExprSet.union input aexprs_to_add
    | _ -> input

  let transfer input label stmt =
    let input = kill input stmt in
    gen input label stmt |> AExprSet.filter is_non_trivial_arith_expression
end

module Handle_AvailableExpressions = RegisterAnalysis (struct
  module MonotoneFrameworkParameters = MFP_AvailableExpressions

  let name = "available_expressions"
end)

(*-----------------------------------------------------------------------------
 * Very Busy Expressions
 *---------------------------------------------------------------------------*)

module MFP_VeryBusyExpressions = struct
  module ControlFlowGraphView = While.Cfg.BackwardControlFlowGraphView

  type domain = AExprSet.t

  let to_string = While.Printer.string_of_arith_expression_set

  let bot labeled_block _ =
    While.Ast.aexprs_of_labeled_block_set labeled_block
    |> AExprSet.filter is_non_trivial_arith_expression

  let extreme _ _ = AExprSet.empty
  let less_or_equal a b = AExprSet.subset b a
  let join = AExprSet.inter

  let kill input = function
    | STMT_Assign { lhs; _ } ->
        let pred aexpr =
          let vars = vars_of_arith_expression_set aexpr in
          not @@ IdSet.mem lhs vars
        in
        AExprSet.filter pred input
    | _ -> input

  let gen input _ = function
    | STMT_Assign { rhs; _ } ->
        let aexprs_to_add = aexprs_of_arith_expression_set rhs in
        AExprSet.union aexprs_to_add input
    | STMT_IfGoto { cond; _ } ->
        let aexprs_to_add = aexprs_of_bool_expression_set cond in
        AExprSet.union input aexprs_to_add
    | _ -> input

  let transfer input label stmt =
    let input = kill input stmt in
    gen input label stmt |> AExprSet.filter is_non_trivial_arith_expression
end

module Handle_VeryBusyExpressions = RegisterAnalysis (struct
  module MonotoneFrameworkParameters = MFP_VeryBusyExpressions

  let name = "very_busy_expressions"
end)

(*-----------------------------------------------------------------------------
 * Live Variables
 *---------------------------------------------------------------------------*)

module MFP_LiveVariables = struct
  module ControlFlowGraphView = While.Cfg.BackwardControlFlowGraphView

  type domain = IdSet.t

  let to_string = string_of_idset
  let bot _ _ = IdSet.empty
  let extreme = bot
  let less_or_equal = IdSet.subset
  let join = IdSet.union

  let kill input = function
    | STMT_Assign { lhs; _ } -> IdSet.remove lhs input
    | _ -> input

  let gen input _ = function
    | STMT_Assign { rhs; _ } ->
        let vars = vars_of_arith_expression_set rhs in
        IdSet.union vars input
    | STMT_IfGoto { cond; _ } ->
        let vars = vars_of_bool_expression_set cond in
        IdSet.union vars input
    | _ -> input

  let transfer input label stmt =
    let input = kill input stmt in
    gen input label stmt
end

module Handle_LiveVariables = RegisterAnalysis (struct
  module MonotoneFrameworkParameters = MFP_LiveVariables

  let name = "live_variables"
end)

(*-----------------------------------------------------------------------------
 * Constant Propagation
 *---------------------------------------------------------------------------*)

module IntWithTop = struct
  type t = Top | IntConst of int

  let equal a b =
    match (a, b) with
    | Top, Top -> true
    | Top, _ | _, Top -> false
    | IntConst a, IntConst b -> a == b

  let less_or_equal a b =
    match (a, b) with _, Top -> true | _, _ -> if a = b then true else false

  let join a b = if equal a b then a else Top
  let to_string i = match i with Top -> "⊤" | IntConst i -> string_of_int i

  let add x y =
    match (x, y) with
    | Top, _ -> Top
    | _, Top -> Top
    | IntConst x, IntConst y -> IntConst (x + y)

  let mul x y =
    match (x, y) with
    | Top, _ -> Top
    | _, Top -> Top
    | IntConst x, IntConst y -> IntConst (x * y)

  let sub x y =
    match (x, y) with
    | Top, _ -> Top
    | _, Top -> Top
    | IntConst x, IntConst y -> IntConst (x - y)

  let div x y =
    match (x, y) with
    | Top, _ -> Top
    | _, Top -> Top
    | IntConst x, IntConst y -> IntConst (x / y)

  let neg x = match x with Top -> Top | IntConst x -> IntConst (-x)
end

module MFP_ConstantPropagation = struct
  module VarMap = Map.Make (struct
    type t = id

    let compare = compare
  end)

  module ControlFlowGraphView = While.Cfg.ForwardControlFlowGraphView

  type domain = IntWithTop.t VarMap.t option

  let to_string = function
    | None -> "⊥"
    | Some m ->
        let f (k, v) =
          Format.sprintf "%s=%s" (string_of_id k) (IntWithTop.to_string v)
        in
        let seq = VarMap.to_seq m in
        let seq = Seq.map f seq in
        String.concat " " @@ List.of_seq seq

  let less_or_equal a b =
    match (a, b) with
    | None, _ -> true
    | _, None -> false
    | Some a, Some b ->
        let seq = VarMap.to_seq a in
        let f (k, va) =
          let vb = VarMap.find k b in
          IntWithTop.less_or_equal va vb
        in
        let seq = Seq.map f seq in
        Seq.fold_left ( && ) true seq

  let equal a b =
    match (a, b) with
    | None, None -> true
    | Some a, Some b ->
        let seq = VarMap.to_seq a in
        let f (k, va) =
          let vb = VarMap.find k b in
          IntWithTop.equal va vb
        in
        let seq = Seq.map f seq in
        Seq.fold_left ( && ) true seq
    | _, _ -> false

  let bot _ _ = None

  let extreme program _ =
    let m =
      Ast.vars_of_labeled_block_seq program
      |> Seq.map (fun x -> (x, IntWithTop.Top))
      |> VarMap.of_seq
    in
    Some m

  let join a b =
    match (a, b) with
    | None, b -> b
    | a, None -> a
    | Some a, Some b ->
        let f _ va vb = Some (IntWithTop.join va vb) in
        Some (VarMap.union f a b)

  let bin_op = function
    | BINOP_Add -> IntWithTop.add
    | BINOP_Sub -> IntWithTop.sub
    | BINOP_Mul -> IntWithTop.mul
    | BINOP_Div -> IntWithTop.div

  let un_op = function UNOP_Neg -> IntWithTop.neg

  let rec eval (expr : arith_expression) (vm : IntWithTop.t VarMap.t) :
      IntWithTop.t =
    match expr with
    | AEXPR_Int { value } -> IntConst value
    | AEXPR_Var { var } -> VarMap.find var vm
    | AEXPR_BinOp { op; lhs; rhs } ->
        let l = eval lhs vm in
        let r = eval rhs vm in
        bin_op op l r
    | AEXPR_UnOp { op; sub } ->
        let e = eval sub vm in
        un_op op e

  let transfer input _ stmt =
    match input with
    | None -> None
    | Some input -> (
        match stmt with
        | STMT_Assign { lhs; rhs; _ } ->
            let v = eval rhs input in
            let vm = VarMap.add lhs v input in
            Some vm
        | _ -> Some input)
end

module Handle_ConstantPropagation = RegisterAnalysis (struct
  module MonotoneFrameworkParameters = MFP_ConstantPropagation

  let name = "constant_propagation"
end)
