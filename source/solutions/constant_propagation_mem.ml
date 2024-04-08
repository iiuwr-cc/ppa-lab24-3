open Common.Ast
open While_mem
open Analysis_registry
open Ast
open Pto_types

(*-------------------------- Constant Propagation -------------------------*)

module Domain = struct
  type t = Top | Null | IntConst of int | Var of id | Bot

  let equal a b =
    match (a, b) with
    | Top, Top -> true
    | Null, Null -> true
    | IntConst a, IntConst b -> a == b
    | Var x, Var y -> x = y
    | Bot, Bot -> true
    | _, _ -> false

  let less_or_equal a b =
    match (a, b) with _, Top -> true | Bot, _ -> true | _, _ -> a = b

  let join a b =
    match (a, b) with
    | a, Bot -> a
    | Bot, a -> a
    | _, _ -> if equal a b then a else Top

  let to_string i =
    match i with
    | Top -> "⊤"
    | Null -> "N"
    | IntConst i -> string_of_int i
    | Var i -> Format.sprintf "&amp;%s" (string_of_id i)
    | Bot -> "⊥"

  let add x y =
    match (x, y) with
    | Bot, _ -> Bot
    | _, Bot -> Bot
    | Top, _ -> Top
    | _, Top -> Top
    | IntConst x, IntConst y -> IntConst (x + y)
    | _, _ -> Bot

  let mul x y =
    match (x, y) with
    | Bot, _ -> Bot
    | _, Bot -> Bot
    | Top, _ -> Top
    | _, Top -> Top
    | IntConst x, IntConst y -> IntConst (x * y)
    | _, _ -> Bot

  let sub x y =
    match (x, y) with
    | Bot, _ -> Bot
    | _, Bot -> Bot
    | Top, _ -> Top
    | _, Top -> Top
    | IntConst x, IntConst y -> IntConst (x - y)
    | _, _ -> Bot

  let div x y =
    match (x, y) with
    | Bot, _ -> Bot
    | _, Bot -> Bot
    | Top, _ -> Top
    | _, Top -> Top
    | _, IntConst 0 -> Bot
    | IntConst x, IntConst y -> IntConst (x / y)
    | _, _ -> Bot

  let neg x =
    match x with
    | Bot -> Bot
    | Top -> Top
    | IntConst x -> IntConst (-x)
    | Null -> Bot
    | Var _ -> Bot
end

module MFP_ConstantPropagation (PtoAnalysis : SPtoAnalysis) = struct
  module ControlFlowGraphView = While_mem.Cfg.ForwardControlFlowGraphView

  module Pts = struct
    let data = PtoResultImp.create ()
    let lookup label loc = PtoResultImp.lookup_pre data label loc
  end

  type domain = Domain.t IdMap.t option

  let to_string = function
    | None -> "⊥"
    | Some m ->
        let f (k, v) =
          Format.sprintf "%s=%s" (string_of_id k) (Domain.to_string v)
        in
        let seq = IdMap.to_seq m in
        let seq = Seq.map f seq in
        String.concat " " @@ List.of_seq seq

  let less_or_equal a b =
    match (a, b) with
    | None, _ -> true
    | _, None -> false
    | Some a, Some b ->
        let seq = IdMap.to_seq a in
        let f (k, va) =
          let vb = IdMap.find k b in
          Domain.less_or_equal va vb
        in
        let seq = Seq.map f seq in
        Seq.fold_left ( && ) true seq

  let equal a b =
    match (a, b) with
    | None, None -> true
    | Some a, Some b ->
        let seq = IdMap.to_seq a in
        let f (k, va) =
          let vb = IdMap.find k b in
          Domain.equal va vb
        in
        let seq = Seq.map f seq in
        Seq.fold_left ( && ) true seq
    | _, _ -> false

  let bot _ _ = None

  let extreme program _ =
    let m =
      Ast.vars_of_labeled_block_seq program
      |> Seq.map (fun x -> (x, Domain.Top))
      |> IdMap.of_seq
    in
    Some m

  let join a b =
    match (a, b) with
    | None, b -> b
    | a, None -> a
    | Some a, Some b ->
        let f _ va vb = Some (Domain.join va vb) in
        Some (IdMap.union f a b)

  let bin_op = function
    | BINOP_Add -> Domain.add
    | BINOP_Sub -> Domain.sub
    | BINOP_Mul -> Domain.mul
    | BINOP_Div -> Domain.div

  let un_op vm = function
    | UNOP_Neg -> Domain.neg
    | UNOP_Deref -> (
        function
        | Var i -> IdMap.find i vm | Null | IntConst _ | Bot -> Bot | Top -> Top
        )

  let rec eval (expr : arith_expression) (vm : Domain.t IdMap.t) : Domain.t =
    match expr with
    | AEXPR_Int { value } -> IntConst value
    | AEXPR_Null -> Null
    | AEXPR_Var { var } -> IdMap.find var vm
    | AEXPR_AddressOf { var } -> Var var
    | AEXPR_BinOp { op; lhs; rhs } ->
        let l = eval lhs vm in
        let r = eval rhs vm in
        bin_op op l r
    | AEXPR_UnOp { op = UNOP_Neg; sub } ->
        let e = eval sub vm in
        un_op vm UNOP_Neg e
    | AEXPR_UnOp { op = UNOP_Deref; sub } ->
        let e = eval sub vm in
        un_op vm UNOP_Deref e

  let find label var = Pts.lookup label var

  let rec leval label =
    let f var set = LocSet.union set @@ find label var in
    function
    | LVALUE_Var { var } -> LocSet.singleton @@ Loc.AddrOfVar var
    | LVALUE_Deref { sub } ->
        let sub = leval label sub in
        LocSet.fold f sub LocSet.empty

  let transfer input label stmt =
    let f v sigma =
      match v with
      | Loc.AddrOfVar id -> IdMap.add id Domain.Top sigma
      | Loc.LabelOfMalloc _ -> sigma
    in
    match input with
    | None -> None
    | Some input -> (
        match stmt with
        | STMT_Assign { lhs; rhs; _ } ->
            let vl = leval label lhs in
            let vr = eval rhs input in
            if LocSet.cardinal vl == 1 then
              match LocSet.min_elt vl with
              | Loc.AddrOfVar id -> Some (IdMap.add id vr input)
              | Loc.LabelOfMalloc _ -> Some input
            else Some (LocSet.fold f vl input)
        | STMT_Malloc { lhs; _ } ->
            let vl = leval label lhs in
            Some (LocSet.fold f vl input)
        | _ -> Some input)

  let init program _cfg =
    PtoResultImp.make Pts.data @@ PtoAnalysis.analyse program _cfg
end

module MyRegisterAnalysis (PtoAnalysis : SPtoAnalysis) =
RegisterAnalysis (struct
  module MonotoneFrameworkParameters = MFP_ConstantPropagation (PtoAnalysis)

  let name = "cp_mem_" ^ PtoAnalysis.name
end)

module Handle_CP_Andersen = MyRegisterAnalysis (Andersen.PtoAnalysis)
(* module Handle_CP_Pto = MyRegisterAnalysis (Pto.PtoAnalysis) *)
