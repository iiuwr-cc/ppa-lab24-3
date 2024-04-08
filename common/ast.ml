(*-----------------------------------------------------------------------------
 * Principles of Program Analysis - Laboratory
 *    University of Wroclaw, Institute of Computer Science
 *---------------------------------------------------------------------------*)

(* This file contains common definitions for Abstract Syntax Tree. 
 *)

(* Identifier *)
type id = Id of string

(* Set of identifiers *)
module IdSet = Set.Make (struct
  type t = id

  let compare = compare
end)

(* Map where keys are identifiers *)
module IdMap = Map.Make (struct
  type t = id

  let compare = compare
end)

let string_of_id (Id id) = id

let string_of_idset idset =
  let seq = IdSet.to_seq idset in
  let seq = Seq.map string_of_id seq in
  let seq = List.of_seq seq in
  let seq = String.concat ", " seq in
  Format.sprintf "{%s}" seq

let string_of_idmap f idmap =
  let g (k, v) =
    let k = string_of_id k in
    let v = f v in
    Format.sprintf "%s=%s" k v
  in
  let seq = IdMap.to_seq idmap in
  let seq = Seq.map g seq in
  let seq = List.of_seq seq in
  let seq = String.concat ", " seq in
  Format.sprintf "{%s}" seq

(* AST labels. *)
type label = EntryLabel | ExitLabel | Label of int

(* Set of ast labels *)
module LabelSet = Set.Make (struct
  type t = label

  let compare = compare
end)

let string_of_label = function
  | EntryLabel -> "Lentry"
  | Label l -> Format.sprintf "L%03u" l
  | ExitLabel -> "Lexit"

let string_of_label_set m =
  LabelSet.to_seq m |> To_string.set_seq_to_string string_of_label

let is_normal_label = function Label _ -> true | _ -> false

(* Location in source file *)
type location = Loc of { file : string; column : int; line : int }

(* Utility for Lexing-based code *)
let mkLoc pos =
  let line = pos.Lexing.pos_lnum in
  let column = pos.Lexing.pos_cnum - pos.Lexing.pos_bol + 1 in
  let file = pos.Lexing.pos_fname in
  Loc { file; column; line }

let string_of_location (Loc { file; column; line }) =
  Format.sprintf "%s:%u:%u" file line column

(* Exception for lexers *)
exception InvalidToken of location * string
