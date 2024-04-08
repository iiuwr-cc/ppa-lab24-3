(*-----------------------------------------------------------------------------
 * Principles of Program Analysis - Laboratory
 *    University of Wroclaw, Institute of Computer Science
 *---------------------------------------------------------------------------*)

(* Module defines all interfaces required to implement and use the
   MonotoneFramework *)

open Common.Ast
open Ast
open Cfg

(* Definition of analysis as an instance of the MonotoneFramework.
 * The `bot` and `join` elements are names of operations required by monotone
 * framework to perform analysis. They can correspond to bot/join or top/meet
 * elements/operators of a lattice.
 *)
module type SMonotoneFrameworkParameters = sig
  (* The type used for representing analysis domain *)
  type domain

  (* View of control flow graph - used to mark analysis as forward or backward *)
  module ControlFlowGraphView : SControlFlowGraphView

  (* Conversion function from domain to a string - used for printing data *)
  val to_string : domain -> string

  (* The transfer function:
   *    transfer input label stmt = output
   * input  - input knowledge
   * label  - label of given statement
   * stmt   - statement
   * output - computed knowledge
   *)
  val transfer : domain -> label -> seq_statement -> domain

  (* The bottom element:
   *    bot labeled_block cfg = output
   * labeled_block - analysed program
   * cfg           - control flow graph of the program
   * output        - computed bottom element
   * 
   * The bottom element can depend on analysed program, e.g. the finite set of all
   * program variables occuring in the program. The `bot` function can handle
   * this dependency and compute the real bottom element. 
   *)
  val bot : labeled_block -> ControlFlowGraph.t -> domain

  (* The extreme element:
   *    extreme labeled_block cfg = output
   * labeled_block - analyzed program
   * cfg           - control flow graph of the program
   * output        - computed extreme value
   *
   * Like the bottom element, the extreme value can depend on analysed program.
   *)
  val extreme : labeled_block -> ControlFlowGraph.t -> domain

  (* Join knowledges *)
  val join : domain -> domain -> domain

  (* Order *)
  val less_or_equal : domain -> domain -> bool
end

(* Statistics for measuring efficiency of algorithm *)
type stats = {
  stat_transfers : int ref;
  stat_less_or_equal : int ref;
  stat_join : int ref;
}

(* Wrap MonotoneFramework parameters with measurements *)
module WrapWithMeasurements (P : SMonotoneFrameworkParameters) = struct
  let stats =
    { stat_transfers = ref 0; stat_less_or_equal = ref 0; stat_join = ref 0 }

  module ControlFlowGraphView = P.ControlFlowGraphView

  type domain = P.domain

  let to_string = P.to_string

  let transfer d l p =
    incr stats.stat_transfers;
    P.transfer d l p

  let bot = P.bot

  let join a b =
    incr stats.stat_join;
    P.join a b

  let less_or_equal a b =
    incr stats.stat_less_or_equal;
    P.less_or_equal a b

  let extreme = P.extreme
end

(* Instance of MonotoneFramework *)
module type SMonotoneFrameworkInstance = sig
  (* The type representing analysis domain *)
  type domain

  (* Parameters of MonotoneFramework *)
  module Parameters : SMonotoneFrameworkParameters with type domain = domain

  (* The type representing result of analysis.
   * It is a mapping from labels to pair of knowledge on entry and exit of
   * program point named by given label.
   *)
  type result = (label, domain * domain) Hashtbl.t

  (* Stringized version analysis result. Used for printing data *)
  type string_result = (label, string * string) Hashtbl.t

  (* Analyse program *)
  val analyse : labeled_block -> ControlFlowGraph.t -> result

  (* Stringize result *)
  val stringize : result -> string_result

  (* Algorithm used to compute analysis *)
  val algorithm_name : string
end

(* Representation of analysis implementing MonotoneFramework.
 * It gets MonotoneFramework parameters as input and creates the instance.
 *)
module type SMonotoneFrameworkAlgorithm = functor
  (_ : SMonotoneFrameworkParameters)
  -> SMonotoneFrameworkInstance
