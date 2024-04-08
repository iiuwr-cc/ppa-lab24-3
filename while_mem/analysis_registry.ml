(*-----------------------------------------------------------------------------
 * Principles of Program Analysis - Laboratory
 *    University of Wroclaw, Institute of Computer Science
 *---------------------------------------------------------------------------*)

open Analysis

module type SRegistryParameters = sig
  module type SData
end

module MakeRegister (P : SRegistryParameters) = struct
  open P

  type data = (module SData)

  let registry : (string, data) Hashtbl.t = Hashtbl.create 513

  let register name data =
    try
      ignore (Hashtbl.find registry name);
      failwith @@ Format.sprintf "Registery already contains key %s" name
    with Not_found -> Hashtbl.replace registry name data

  let content () = List.of_seq @@ Hashtbl.to_seq_keys registry

  let lookup name =
    try
      let data = Hashtbl.find registry name in
      let module Data = (val data : SData) in
      (module Data : SData)
    with Not_found ->
      failwith @@ Format.sprintf "Registry does not contain key %s" name
end

(* **************)

module AnalysisRegistry = MakeRegister (struct
  module type SData = SMonotoneFrameworkParameters
end)

module AlgorithmRegistry = MakeRegister (struct
  module type SData = SMonotoneFrameworkAlgorithm
end)

let lookup_analysis = AnalysisRegistry.lookup
let lookup_algorithm = AlgorithmRegistry.lookup
let analysis_list = AnalysisRegistry.content
let algorithm_list = AlgorithmRegistry.content

module type SAnalysisEntry = sig
  val name : string

  module MonotoneFrameworkParameters : SMonotoneFrameworkParameters
end

module RegisterAnalysis (E : SAnalysisEntry) = struct
  let _ =
    let entry =
      (module E.MonotoneFrameworkParameters : SMonotoneFrameworkParameters)
    in
    AnalysisRegistry.register E.name entry
end

module type SAlgorithmEntry = sig
  val name : string

  module Algorithm : SMonotoneFrameworkAlgorithm
end

module RegisterAlgorithm (E : SAlgorithmEntry) = struct
  let _ =
    let entry = (module E.Algorithm : SMonotoneFrameworkAlgorithm) in
    AlgorithmRegistry.register E.name entry
end
