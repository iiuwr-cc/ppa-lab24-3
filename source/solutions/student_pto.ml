(*-----------------------------------------------------------------------------
 * Principles of Program Analysis - Laboratory
 *    University of Wroclaw, Institute of Computer Science
 *---------------------------------------------------------------------------*)

open Common.Ast
open While_mem
open Analysis_registry
open Ast
open Pto_types

(*-----------------------------------------------------------------------------
 * Pto
 *---------------------------------------------------------------------------*)

(* Student's task:
 * uncomment the code below,
 * uncomment the last line in file `constant_propagation_mem.ml`,
 * make it work. *)

(*

module MFP_Pto = struct
  module ControlFlowGraphView = Cfg.ForwardControlFlowGraphView

  module D_Domain = struct
    type t = Bot | Locs of LocSet.t

    (* Feel free to add code here. *)
  end

  module L_Domain = struct
    type t = Map of D_Domain.t LocMap.t

    (* Feel free to add code here. *)
  end

  type domain = L_Domain.t

  (* Feel free to add code here. *)

  let to_string = failwith "not yet implemented"
  let bot = failwith "not yet implemented"
  let join = failwith "not yet implemented"
  let less_or_equal = failwith "not yet implemented"
  let extreme = failwith "not yet implemented"
  let transfer = failwith "not yet implemented"
  let init _ _ = ()
end

module Handle_Pto = RegisterAnalysis (struct
  module MonotoneFrameworkParameters = MFP_Pto

  let name = "pto"
end)

module PtoAnalysis : SPtoAnalysis = struct
  let d_to_locset = function
    | MFP_Pto.D_Domain.Bot -> LocSet.empty
    | MFP_Pto.D_Domain.Locs l -> l

  let to_locmap = function MFP_Pto.L_Domain.Map l -> LocMap.map d_to_locset l

  let repack h =
    let result = Hashtbl.create 513 in
    let f k (a, b) = Hashtbl.replace result k (to_locmap a, to_locmap b) in
    Hashtbl.iter f h;
    result

  let analyse program cfg =
    let module MFP = Chaotic_iteration.Make (MFP_Pto) in
    PtoResult.make_flow_sensitive @@ repack @@ MFP.analyse program cfg

  let name = "pto"
end

 *)
