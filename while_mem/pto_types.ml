(*-----------------------------------------------------------------------------
 * Principles of Program Analysis - Laboratory
 *    University of Wroclaw, Institute of Computer Science
 *---------------------------------------------------------------------------*)

open Common.Ast
open Ast

(* Type of abstract location.
 * - AddrOfVar i
 *   abstracts the memory address of a variable `i`
 * - LabelOfMalloc l ->
 *   abstracts all memory addresses allocated by calls to malloc at label `l`
 *)
module Loc = struct
  type t = AddrOfVar of id | LabelOfMalloc of label

  let to_string = function
    | AddrOfVar i -> string_of_id i
    | LabelOfMalloc l -> string_of_label l

  let compare : t -> t -> int = compare
  let equal a b = a = b
end

module LocSet = Set.Make (Loc)
module LocMap = Map.Make (Loc)

let string_of_locset xs =
  xs |> LocSet.to_seq |> Common.To_string.set_seq_to_string Loc.to_string

let string_of_locmap f xs =
  xs |> LocMap.to_seq |> Common.To_string.map_seq_to_string Loc.to_string f

module LocSetView = struct
  type t = ExaclyOne of Loc.t | Set of LocSet.t

  let view_of_locset xs =
    if LocSet.cardinal xs = 1 then ExaclyOne (LocSet.min_elt xs) else Set xs
end

module PtoResult = struct
  (* locations to locations *)
  type loc2locs = LocSet.t LocMap.t
  type flow_sensitive = (label, loc2locs * loc2locs) Hashtbl.t
  type flow_insensitive = loc2locs

  type t =
    | FlowSensitive of flow_sensitive
    | FlowInsensitive of flow_insensitive

  let _pre l = function
    | FlowInsensitive loc2locs -> loc2locs
    | FlowSensitive table -> (
        match Hashtbl.find_opt table l with
        | Some (pre, _) -> pre
        | None -> LocMap.empty)

  let _post l = function
    | FlowInsensitive loc2locs -> loc2locs
    | FlowSensitive table -> (
        match Hashtbl.find_opt table l with
        | Some (_, post) -> post
        | None -> LocMap.empty)

  let _lookup l r =
    match LocMap.find_opt l r with None -> LocSet.empty | Some x -> x

  let lookup_pre t l x = _lookup x @@ _pre l t
  let lookup_view_pre t l x = LocSetView.view_of_locset @@ lookup_pre t l x
  let lookup_post t l x = _lookup x @@ _pre l t
  let lookup_view_post t l x = LocSetView.view_of_locset @@ lookup_post t l x
  let make_flow_sensitive x = FlowSensitive x
  let make_flow_insensitive x = FlowInsensitive x
end

module PtoResultImp = struct
  type t = PtoResult.t ref

  let create () = ref @@ PtoResult.make_flow_insensitive @@ LocMap.empty
  let make_flow_sensitive t x = t := PtoResult.make_flow_sensitive x
  let make_flow_insensitive t x = t := PtoResult.make_flow_insensitive x
  let make t x = t := x
  let lookup_pre t l x = PtoResult.lookup_pre !t l x
  let lookup_view_pre t l x = PtoResult.lookup_view_pre !t l x
  let lookup_post t l x = PtoResult.lookup_post !t l x
  let lookup_view_post t l x = PtoResult.lookup_view_post !t l x
end

module type SPtoAnalysis = sig
  val analyse : labeled_block -> Cfg.ControlFlowGraph.t -> PtoResult.t
  val name : string
end
