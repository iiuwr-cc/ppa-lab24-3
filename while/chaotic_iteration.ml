(*-----------------------------------------------------------------------------
 * Principles of Program Analysis - Laboratory
 *    University of Wroclaw, Institute of Computer Science
 *---------------------------------------------------------------------------*)

(* Implementation of simple chaotic-iteration algorithm *)

open Common.Ast
open Ast
open Cfg
open Analysis
open Analysis_registry

let algorithm_name = "chaotic-iteration"

module Make (P : SMonotoneFrameworkParameters) : SMonotoneFrameworkInstance =
struct
  let algorithm_name = algorithm_name

  module Parameters = P

  type domain = Parameters.domain
  type result = (label, domain * domain) Hashtbl.t
  type string_result = (label, string * string) Hashtbl.t

  (* stringize given table *)
  let stringize result =
    let h = Hashtbl.create 513 in
    let f k (input, output) =
      let input = Parameters.to_string input in
      let output = Parameters.to_string output in
      Hashtbl.replace h k (input, output)
    in
    Hashtbl.iter f result;
    h

  (* Helper type. `InternalPair (a,b)` represents knowledge for particular
   * program point. Elements `a` and `b` represents input and output of
   * transfer function associated to given program point. For forward 
   * analysis the order of pair components is the same as in a result table.
   * For backward analysis the order is reversed. This type is introduced to
   * distinguish transfer-related (input,output) pairs with ones from result
   * table.
   *)
  type internal_pair = InternalPair of domain * domain

  (* Convert (input,output) pair from result-table-related to transfer-related *)
  let reorder_to_analysis =
    if Parameters.ControlFlowGraphView.is_reversed then fun (a, b) ->
      InternalPair (b, a)
    else fun (a, b) -> InternalPair (a, b)

  (* Convert (input,output) pair from transfer-related to result-table-related *)
  let reorder_from_analysis =
    if Parameters.ControlFlowGraphView.is_reversed then
      fun (InternalPair (a, b)) -> (b, a)
    else fun (InternalPair (a, b)) -> (a, b)

  (* Constructors and eliminators for our pair *)
  let internal_pair (a, b) = InternalPair (a, b)
  let first (InternalPair (a, _)) = a
  let second (InternalPair (_, b)) = b

  (* Worker instance *)
  module Worker (X : sig
    val program : labeled_block
    val cfg : ControlFlowGraph.t
  end) =
  struct
    open X

    (* Entry label *)
    let entry = Parameters.ControlFlowGraphView.entry cfg

    (* Computed bottom-element *)
    let bot = Parameters.bot program cfg

    (* Computed extreme-element *)
    let extreme = Parameters.extreme program cfg

    (* Initial result-table. The entry label is initialized with extreme
     * value as transfer-input and each other element is initialized to
     * computed bottom value.
     *)
    let result =
      let h = Hashtbl.create 513 in
      let init l = Hashtbl.replace h l (bot, bot) in
      List.iter init @@ ControlFlowGraph.labels_with_specials cfg;
      let extreme = internal_pair (extreme, bot) in
      let extreme = reorder_from_analysis extreme in
      Hashtbl.replace h entry extreme;
      h

    (* Check if two knowledges are equal *)
    let equal a b = Parameters.less_or_equal a b && Parameters.less_or_equal b a

    (* Negation of equality *)
    let different a b = not @@ equal a b

    (* The the transfer-output from result-table *)
    let output label =
      let kw = Hashtbl.find result label in
      let kw = reorder_to_analysis kw in
      second kw

    (* Join transfer-output of all predecessors (from VIEW of cfg) of given
     * vertex. *)
    let summarize_predecessors label old_input =
      if label <> entry then
        let preds = Parameters.ControlFlowGraphView.predecessors cfg label in
        let preds = List.to_seq preds in
        let preds = Seq.map output preds in
        Seq.fold_left Parameters.join bot preds
      else old_input

    (* Transfer knowledge. *)
    let transfer label =
      (* Get current (input,output) pair from result table *)
      let kw = Hashtbl.find result label in
      (* Reorder it to transfer-related pair*)
      let kw = reorder_to_analysis kw in
      let input = first kw in
      let input = summarize_predecessors label input in
      (* Get the old output *)
      let old_output = second kw in
      (* Compute new output ... *)
      let output =
        if is_normal_label label then
          (* ... by transfer function for label related to program instruction *)
          let stmt = ControlFlowGraph.statement cfg label in
          Parameters.transfer input label stmt
        else (* .... by identity transfer for distinguished label *)
          input
      in
      (* Store result in result-table *)
      let kw = internal_pair (input, output) in
      let kw = reorder_from_analysis kw in
      Hashtbl.replace result label kw;
      (* Check if knowledge for given label has changed *)
      different output old_output

    let step () =
      (* Recompute all vertices *)
      let labels = ControlFlowGraph.labels_with_specials cfg in
      let seq = List.to_seq labels in
      let seq = Seq.map transfer seq in
      (* Check if knowledge has changed *)
      Seq.fold_left ( || ) false seq

    (* Compute analysis *)
    let run () =
      let rec loop () = if step () then loop () in
      loop ()
  end

  let analyse program cfg =
    let module Instance = Worker (struct
      let program = program
      let cfg = cfg
    end) in
    Instance.run ();
    Instance.result
end

(* Register algorithm in registry *)
module Handle_ChaoticIteratation = RegisterAlgorithm (struct
  let name = algorithm_name

  module Algorithm = Make
end)
