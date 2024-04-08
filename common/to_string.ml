(*-----------------------------------------------------------------------------
 * Principles of Program Analysis - Laboratory
 *    University of Wroclaw, Institute of Computer Science
 *---------------------------------------------------------------------------*)

(* Silly helpers for printing containers.
 *)

let set_seq_to_string elt_to_string seq =
  let xs = List.of_seq seq in
  let xs = List.sort compare xs in
  List.map elt_to_string xs |> String.concat ", " |> Format.sprintf "{%s}"

let map_seq_to_string key_to_string elt_to_string seq =
  let f (k, v) = (key_to_string k, elt_to_string v) in
  let g (k, v) = Format.sprintf "%s=%s" k v in
  Seq.map f seq |> List.of_seq |> List.sort compare |> List.map g
  |> String.concat ", "
