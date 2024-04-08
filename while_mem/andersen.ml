(*-----------------------------------------------------------------------------
 * Principles of Program Analysis - Laboratory
 *    University of Wroclaw, Institute of Computer Science
 *---------------------------------------------------------------------------*)

(* This module contains implementation of Andersen's Flow-Insensitive Alias
 * Analysis. 
 *
 * Our language supports more complex memory operations than constraints
 * from algorithm can handle. To overcome this problem we introduced
 * a mini compiler during constraint generation. For example:
 *      **dst = **src;
 * will be compiled into:
 *      tmp0 = *src; tmp1 = *tmp0; tmp2 = *dst; *tmp2 = tmp1;
 * where all `tmpN` are fresh variables.
 *
 * TODO:
 * - code cleanup
 * - extend tester.py to allow automatic tests for Andersen
 * - variable cache in constraint generator: since analysis is flow-insensitive
 *   we can share fresh variables when they are initialized by the same memory
 *   operation. For example, consider two instructions `tmp0 = *x` and `tmp1 = *x`.
 *   Variables `tmp0` and `tmp1` will have the same points-to set. 
 *)

open Ast
open Common.Ast
open Pto_types

module type S = sig
  val verbose : bool
  val print : bool
end

module Elem = struct
  type t = Loc of Loc.t | Temp of int

  let to_string = function
    | Loc x -> Loc.to_string x
    | Temp t -> Format.sprintf "$tmp%u" t

  let compare = compare
  let equal a b = a = b
  let hash = Hashtbl.hash
  let var i = Loc (Loc.AddrOfVar i)
  let malloc i = Loc (Loc.LabelOfMalloc i)
  let temp i = Temp i
  let as_loc = function Loc l -> l | Temp _ -> failwith "Elem.Temp is not loc"
  let is_loc = function Loc _ -> true | _ -> false
end

module ElemSet = struct
  include Set.Make (Elem)

  let to_string t = Common.To_string.set_seq_to_string Elem.to_string (to_seq t)
end

module Constr = struct
  type t =
    (* {id} \subseteq pts(elem) *)
    | ElemInNormal of Elem.t * Elem.t
    (* pts(elem1) \subseteq pts(elem2) *)
    | IncludeNormalNormal of Elem.t * Elem.t
    (* forall x : pts(elem1). pts(x) \subseteq pts(elem2) *)
    | IncludeDerefNormal of Elem.t * Elem.t
    (* forall x: pts(elem2). pts(elem1) \subseteq pts(x) *)
    | IncludeNormalDeref of Elem.t * Elem.t

  let to_string = function
    | ElemInNormal (id, elem) ->
        Format.sprintf "{%s} -> pts(%s)" (Elem.to_string id)
          (Elem.to_string elem)
    | IncludeNormalNormal (elem1, elem2) ->
        Format.sprintf "pts(%s) -> pts(%s)" (Elem.to_string elem1)
          (Elem.to_string elem2)
    | IncludeDerefNormal (elem1, elem2) ->
        Format.sprintf "forall %%x : pts(%s). pts(%%x) -> pts(%s)"
          (Elem.to_string elem1) (Elem.to_string elem2)
    | IncludeNormalDeref (elem1, elem2) ->
        Format.sprintf "forall %%x : pts(%s). pts(%s) -> pts(%%x)"
          (Elem.to_string elem2) (Elem.to_string elem1)
end

(* Module is marked as generative to make sure that global variables
 * are not really global. *)

module Implementation (P : S) () = struct
  open P

  module ConstraintGenerator = struct
    let gen_temp =
      let counter = ref 0 in
      fun () ->
        let c = !counter in
        incr counter;
        Elem.Temp c

    type op =
      | Normal of Elem.t
      | Deref of Elem.t
      | AddrOf of id
      | Malloc of label

    let string_of_op = function
      | Normal n -> Elem.to_string n
      | Deref n -> Format.sprintf "*%s" (Elem.to_string n)
      | AddrOf n -> Format.sprintf "&%s" (string_of_id n)
      | Malloc l -> Format.sprintf "malloc(%s)" (string_of_label l)

    let string_of_eq (a, b) =
      Format.sprintf "%s = %s" (string_of_op a) (string_of_op b)

    let rec full_read_aexpr = function
      | AEXPR_Var { var } -> Some ([], Elem.var var)
      | AEXPR_UnOp { op = UNOP_Deref; sub = AEXPR_AddressOf { var } } ->
          Some ([], Elem.var var)
      | AEXPR_UnOp { op = UNOP_Deref; sub } -> (
          match full_read_aexpr sub with
          | Some (eqs, sub) ->
              let tmp = gen_temp () in
              let eq = (Normal tmp, Deref sub) in
              Some (eq :: eqs, tmp)
          | _ -> None)
      | _ -> None

    let read_aexpr = function
      | AEXPR_AddressOf { var } -> Some ([], AddrOf var)
      | AEXPR_UnOp { op = UNOP_Deref; sub = AEXPR_Var { var } } ->
          Some ([], Deref (Elem.var var))
      | AEXPR_UnOp { op = UNOP_Deref; sub = AEXPR_AddressOf { var } } ->
          Some ([], Normal (Elem.var var))
      | AEXPR_UnOp { op = UNOP_Deref; sub } -> (
          match full_read_aexpr sub with
          | Some (eqs, sub) -> Some (eqs, Deref sub)
          | _ -> None)
      | sub -> (
          match full_read_aexpr sub with
          | Some (eqs, sub) -> Some (eqs, Normal sub)
          | None -> None)

    let rec read_lvalue = function
      | LVALUE_Var { var } -> ([], Elem.var var)
      | LVALUE_Deref { sub } ->
          let eqs, sub = read_lvalue sub in
          let tmp = gen_temp () in
          let eq = (Normal tmp, Deref sub) in
          (eq :: eqs, tmp)

    let eval_lvalue = function
      | LVALUE_Deref { sub } ->
          let eqs, sub = read_lvalue sub in
          (eqs, Deref sub)
      | LVALUE_Var { var } -> ([], Normal (Elem.var var))

    let compile_malloc lhs label =
      match eval_lvalue lhs with
      | eqs, Normal lhs ->
          let op = (Normal lhs, Malloc label) in
          op :: eqs
      | eqs, Deref lhs ->
          let tmp = gen_temp () in
          let op1 = (Normal tmp, Malloc label) in
          let op2 = (Deref lhs, Normal tmp) in
          op1 :: op2 :: eqs
      | _ -> []

    let compile_assign lhs rhs =
      match (eval_lvalue lhs, read_aexpr rhs) with
      | (lhs_eqs, Normal lhs), Some (rhs_eqs, Normal rhs) ->
          let op = (Normal lhs, Normal rhs) in
          List.flatten [ [ op ]; lhs_eqs; rhs_eqs ]
      | (lhs_eqs, Deref lhs), Some (rhs_eqs, Normal rhs) ->
          let op = (Deref lhs, Normal rhs) in
          List.flatten [ [ op ]; lhs_eqs; rhs_eqs ]
      | (lhs_eqs, Normal lhs), Some (rhs_eqs, Deref rhs) ->
          let op = (Normal lhs, Deref rhs) in
          List.flatten [ [ op ]; lhs_eqs; rhs_eqs ]
      | (lhs_eqs, Deref lhs), Some (rhs_eqs, Deref rhs) ->
          let tmp = gen_temp () in
          let op1 = (Deref lhs, Normal tmp) in
          let op2 = (Normal tmp, Deref rhs) in
          List.flatten [ [ op1; op2 ]; lhs_eqs; rhs_eqs ]
      | (lhs_eqs, Normal lhs), Some (rhs_eqs, AddrOf x) ->
          let op = (Normal lhs, AddrOf x) in
          List.flatten [ [ op ]; lhs_eqs; rhs_eqs ]
      | (lhs_eqs, Deref lhs), Some (rhs_eqs, AddrOf x) ->
          let tmp = gen_temp () in
          let op1 = (Deref lhs, Normal tmp) in
          let op2 = (Normal tmp, AddrOf x) in
          List.flatten [ [ op1; op2 ]; lhs_eqs; rhs_eqs ]
      | _ -> []

    let generate_from_eq = function
      | Normal lhs, Normal rhs -> Constr.IncludeNormalNormal (rhs, lhs)
      | Normal lhs, Deref rhs -> Constr.IncludeDerefNormal (rhs, lhs)
      | Deref lhs, Normal rhs -> Constr.IncludeNormalDeref (rhs, lhs)
      | Normal lhs, AddrOf i -> Constr.ElemInNormal (Elem.var i, lhs)
      | Normal lhs, Malloc l -> Constr.ElemInNormal (Elem.malloc l, lhs)
      | c -> failwith @@ Format.sprintf "invalid eq: %s" (string_of_eq c)

    let generate_from_assign lhs rhs =
      match compile_assign lhs rhs with
      | [] -> []
      | eqs ->
          (if verbose then
             let eqs = List.map string_of_eq eqs in
             let eqs = String.concat "; " eqs in
             Format.printf "  - compiled as: %s\n%!" eqs);
          List.map generate_from_eq eqs

    let generate_from_malloc lhs label =
      match compile_malloc lhs label with
      | [] -> []
      | eqs ->
          (if verbose then
             let eqs = List.map string_of_eq eqs in
             let eqs = String.concat "; " eqs in
             Format.printf "  - compiled as: %s\n%!" eqs);
          List.map generate_from_eq eqs

    let generate_from_instr = function
      | label, (STMT_Assign { lhs; rhs; _ } as stmt) ->
          if verbose then
            Format.printf "- analysing statement at label %s: %s\n"
              (string_of_label label)
              (Printer.string_of_seq_statement stmt);
          let cstrs = generate_from_assign lhs rhs in
          (if verbose then
             let handle_cstr c =
               Format.printf "  - constr %s\n%!" (Constr.to_string c)
             in
             List.iter handle_cstr cstrs);
          cstrs
      | label, (STMT_Malloc { lhs; _ } as stmt) ->
          if verbose then
            Format.printf "- analysing statement at label %s: %s\n"
              (string_of_label label)
              (Printer.string_of_seq_statement stmt);
          let cstrs = generate_from_malloc lhs label in
          (if verbose then
             let handle_cstr c =
               Format.printf "  - constr %s\n%!" (Constr.to_string c)
             in
             List.iter handle_cstr cstrs);
          cstrs
      | _ -> []

    let generate_from_program program =
      let cstrs = List.map generate_from_instr program in
      let cstrs = List.flatten cstrs in
      let cstrs = List.sort_uniq compare cstrs in
      cstrs
  end

  module Solver = struct
    open P

    module Elem2Constrs = struct
      let data = Hashtbl.create 513

      let add elem c =
        match Hashtbl.find_opt data elem with
        | None -> Hashtbl.replace data elem [ c ]
        | Some cs -> Hashtbl.replace data elem (c :: cs)

      let lookup elem =
        match Hashtbl.find_opt data elem with None -> [] | Some cs -> cs
    end

    module Pts = struct
      let data = Hashtbl.create 513

      let lookup elem =
        match Hashtbl.find_opt data elem with
        | Some locs -> locs
        | None -> ElemSet.empty

      let addid id elem =
        match Hashtbl.find_opt data elem with
        | Some locs ->
            (if verbose then
               let already_present =
                 if ElemSet.mem id locs then "(was already present)" else ""
               in
               Format.printf "- added variable %s to pts(%s) %s\n%!"
                 (Elem.to_string id) (Elem.to_string elem) already_present);
            let locs = ElemSet.add id locs in
            Hashtbl.replace data elem locs
        | None -> Hashtbl.replace data elem @@ ElemSet.singleton id

      let create elem =
        match Hashtbl.find_opt data elem with
        | Some _ -> ()
        | None -> Hashtbl.replace data elem ElemSet.empty

      let collect_nonempty () =
        let f k v xs = if ElemSet.is_empty v then xs else k :: xs in
        Hashtbl.fold f data []

      let subsume src dst =
        let xsrc = lookup src in
        let xdst = lookup dst in
        let ydst = ElemSet.union xsrc xdst in
        Hashtbl.replace data dst ydst;
        let changed = not @@ ElemSet.equal xdst ydst in
        (if verbose then
           let changed_str = if changed then "(changed)" else "(not changed)" in
           Format.printf "- pts(%s) += pts(%s) %s\n%!" (Elem.to_string dst)
             (Elem.to_string src) changed_str);
        changed

      let print () =
        let f k v =
          Format.printf "%s -> %s\n" (Elem.to_string k) (ElemSet.to_string v)
        in
        Hashtbl.iter f data
    end

    module Graph = struct
      module Impl = Graph.Imperative.Digraph.Concrete (Elem)

      let data = Impl.create ()
      let create elem = Impl.add_vertex data elem

      let add_edge src dst =
        if Impl.mem_edge data src dst then (
          if verbose then
            Format.printf
              "- added edge %s -> %s to graph (was already present)\n%!"
              (Elem.to_string src) (Elem.to_string dst);
          false)
        else (
          if verbose then
            Format.printf "- added edge %s -> %s to graph\n%!"
              (Elem.to_string src) (Elem.to_string dst);
          Impl.add_edge data src dst;
          true)

      let successors v = Impl.succ data v
    end

    module Queue = struct
      let queue = ref []
      let marks = Hashtbl.create 513

      let add (elem : Elem.t) =
        if Hashtbl.mem marks elem then (
          if verbose then
            Format.printf "- added %s to queue (already present in queue)\n%!"
              (Elem.to_string elem))
        else (
          if verbose then
            Format.printf "- added %s to queue\n%!" (Elem.to_string elem);
          Hashtbl.replace marks elem ();
          queue := elem :: !queue)

      let addall elems = List.iter add elems

      let extract () =
        match !queue with
        | [] ->
            if verbose then Format.printf "- no more elements in queue\n%!";
            None
        | x :: xs ->
            if verbose then
              Format.printf "- got %s from queue\n%!" (Elem.to_string x);
            queue := xs;
            Hashtbl.remove marks x;
            Some x
    end

    let rec scan = function
      | Constr.ElemInNormal (id, elem) :: xs ->
          Pts.create elem;
          Graph.create elem;
          Pts.addid id elem;
          scan xs
      | Constr.IncludeNormalNormal (lhs, rhs) :: xs ->
          Pts.create lhs;
          Pts.create rhs;
          let _ = Graph.add_edge lhs rhs in
          scan xs
      | (Constr.IncludeNormalDeref (lhs, rhs) as c) :: xs ->
          Pts.create lhs;
          Pts.create rhs;
          Elem2Constrs.add rhs c;
          Graph.create lhs;
          Graph.create rhs;
          scan xs
      | (Constr.IncludeDerefNormal (lhs, rhs) as c) :: xs ->
          Pts.create lhs;
          Pts.create rhs;
          Elem2Constrs.add lhs c;
          Graph.create lhs;
          Graph.create rhs;
          scan xs
      | [] -> ()

    let handle_constraints v a cstrs =
      let handle = function
        | Constr.IncludeNormalDeref (q, _v) when Elem.equal v _v ->
            let is_edge_new = Graph.add_edge q a in
            if is_edge_new then Queue.add q
        | Constr.IncludeDerefNormal (_v, p) when Elem.equal v _v ->
            let is_edge_new = Graph.add_edge a p in
            if is_edge_new then Queue.add a
        | c ->
            failwith
            @@ Format.sprintf "unhandled constraint: %s" (Constr.to_string c)
      in
      let handle c =
        if verbose then
          Format.printf "- considering constraint %s\n%!" (Constr.to_string c);
        handle c
      in
      List.iter handle cstrs

    let handle_edges v =
      let handle q =
        if verbose then
          Format.printf "- considering edge %s -> %s\n%!" (Elem.to_string v)
            (Elem.to_string q);
        let changed = Pts.subsume v q in
        if changed then Queue.add q
      in
      List.iter handle @@ Graph.successors v

    let rec run () =
      match Queue.extract () with
      | None -> ()
      | Some v ->
          let cstrs = Elem2Constrs.lookup v in
          let handle_a a = handle_constraints v a cstrs in
          ElemSet.iter handle_a @@ Pts.lookup v;
          handle_edges v;
          run ()

    let solve cstrs =
      scan cstrs;
      let start = Pts.collect_nonempty () in
      Queue.addall start;
      run ();
      if print then Pts.print ();
      Pts.data
  end

  let elemset2locset xs =
    xs |> ElemSet.to_seq |> Seq.filter Elem.is_loc |> Seq.map Elem.as_loc
    |> LocSet.of_seq

  let repack table =
    let f k v result =
      match k with
      | Elem.Temp _ -> result
      | Elem.Loc l ->
          let v = elemset2locset v in
          LocMap.add l v result
    in
    Hashtbl.fold f table LocMap.empty

  let analyse program =
    let module Gen = ConstraintGenerator in
    let module Sol = Solver in
    let cstrs = Gen.generate_from_program program in
    repack @@ Sol.solve cstrs
end

let analyse ?(verbose = false) ?(print = false) program =
  let module P = struct
    let verbose = verbose
    let print = print
  end in
  let module Instance = Implementation (P) () in
  Instance.analyse program

module PtoAnalysis : SPtoAnalysis = struct
  let analyse program _ = PtoResult.make_flow_insensitive @@ analyse program
  let name = "andersen"
end
