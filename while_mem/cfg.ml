(*-----------------------------------------------------------------------------
 * Principles of Program Analysis - Laboratory
 *    University of Wroclaw, Institute of Computer Science
 *---------------------------------------------------------------------------*)
open Common.Ast
open Ast

module LabelGraph = Graph.Imperative.Digraph.ConcreteBidirectional (struct
  type t = label

  let equal = ( = )
  let hash = Hashtbl.hash
  let compare = compare
end)

module ControlFlowGraph = struct
  type t = { graph : LabelGraph.t; stmts : (label, seq_statement) Hashtbl.t }

  let create () = { graph = LabelGraph.create (); stmts = Hashtbl.create 513 }
  let graph { graph; _ } = graph
  let successors { graph; _ } = LabelGraph.succ graph
  let predecessors { graph; _ } = LabelGraph.pred graph

  let add_labeled_statement { stmts; graph; _ } (l, s) =
    Hashtbl.replace stmts l s;
    LabelGraph.add_vertex graph l

  let connect { graph; _ } src dst = LabelGraph.add_edge graph src dst

  let labels_with_specials { graph; _ } =
    LabelGraph.fold_vertex (fun l xs -> l :: xs) graph []

  let labels_without_specials { stmts; _ } =
    Hashtbl.to_seq_keys stmts |> List.of_seq

  let statement { stmts; _ } v =
    try Hashtbl.find stmts v
    with Not_found ->
      failwith
      @@ Format.sprintf
           "ControlFlowGraph does not have statement associated with label: %s"
           (string_of_label v)

  let set_statement { stmts; graph; _ } v s =
    LabelGraph.add_vertex graph v;
    Hashtbl.replace stmts v s
end

module type SControlFlowGraphView = sig
  val successors : ControlFlowGraph.t -> label -> label list
  val predecessors : ControlFlowGraph.t -> label -> label list
  val entry : ControlFlowGraph.t -> label
  val exit : ControlFlowGraph.t -> label
  val is_reversed : bool
end

module ForwardControlFlowGraphView : SControlFlowGraphView = struct
  let successors = ControlFlowGraph.successors
  let predecessors = ControlFlowGraph.predecessors
  let entry _ = EntryLabel
  let exit _ = ExitLabel
  let is_reversed = false
end

module BackwardControlFlowGraphView : SControlFlowGraphView = struct
  let successors = ControlFlowGraph.predecessors
  let predecessors = ControlFlowGraph.successors
  let entry _ = ExitLabel
  let exit _ = EntryLabel
  let is_reversed = true
end

let build program =
  let cfg = ControlFlowGraph.create () in
  let register_flow ?prev dst =
    match prev with
    | Some src -> ControlFlowGraph.connect cfg src dst
    | None -> ()
  in
  let add_statement (label, s) = ControlFlowGraph.set_statement cfg label s in
  List.iter add_statement program;
  let scan prev = function
    | label, STMT_Goto { target; _ } ->
        register_flow ?prev label;
        register_flow ~prev:label target;
        None
    | label, STMT_IfGoto { target; _ } ->
        register_flow ?prev label;
        register_flow ~prev:label target;
        Some label
    | label, _ ->
        register_flow ?prev label;
        Some label
  in
  let prev = List.fold_left scan (Some EntryLabel) program in
  register_flow ?prev ExitLabel;
  cfg

module MakeDotPrinter (M : sig
  val cfg : ControlFlowGraph.t
  val result : (label, string * string) Hashtbl.t option
end) =
struct
  open M

  let graph = ControlFlowGraph.graph cfg

  let vertex_name = function
    | Label i -> Format.sprintf "L_%u" i
    | EntryLabel -> "L_entry"
    | ExitLabel -> "L_exit"

  let escape str =
    let n = String.length str in
    let sb = Buffer.create @@ (5 + n) in
    let rec loop = function
      | i when n = i -> Buffer.contents sb
      | i ->
          (match str.[i] with
          | '<' -> Buffer.add_string sb "&lt;"
          | '>' -> Buffer.add_string sb "&gt;"
          | '&' -> Buffer.add_string sb "&amp;"
          | '"' -> Buffer.add_string sb "&quot;"
          | c -> Buffer.add_char sb c);
          loop (succ i)
    in
    loop 0

  let describe_vertex_content = function
    | EntryLabel -> "ENTRY"
    | ExitLabel -> "EXIT"
    | v ->
        let stmt = ControlFlowGraph.statement cfg v in
        let stmt = Printer.string_of_seq_statement stmt in
        escape stmt

  let describe_input, describe_output =
    match result with
    | None ->
        let empty _ = "" in
        (empty, empty)
    | Some result ->
        let find v =
          try Hashtbl.find result v with Not_found -> ("N/A", "N/A")
        in
        let row p s =
          Format.sprintf
            "<tr><td bgcolor='yellow' colspan='2' port='%s'>%s</td></tr>" p s
        in
        let input v = row "e" @@ fst @@ find v in
        let output v = row "x" @@ snd @@ find v in
        (input, output)

  let describe_vertex v =
    let name = vertex_name v in
    let html =
      [
        "<table cellspacing='0' cellborder='1' align='left' border='0'>";
        describe_input v;
        Format.sprintf "<tr><td bgcolor='cyan' port='m'>%s</td><td>%s</td></tr>"
          (string_of_label v)
          (describe_vertex_content v);
        describe_output v;
        "</table>";
      ]
    in

    Format.sprintf "%s[shape=none, margin=0, label=<%s>];" name
      (String.concat "" html)

  let inport, outport =
    match result with Some _ -> ("e", "x") | None -> ("m", "m")

  let describe_edges v =
    let succ = ControlFlowGraph.successors cfg v in
    let v = vertex_name v in
    let f w =
      Format.sprintf "%s:%s -> %s:%s;" v outport (vertex_name w) inport
    in
    List.map f succ

  let print_graph () =
    let labels = ControlFlowGraph.labels_with_specials cfg in
    let content =
      List.concat
        [
          [
            "digraph CFG {";
            "node[shape=none; fontname=\"Courier\" fontsize=\"9\"];";
            "ordering=out;";
          ];
          List.map describe_vertex labels;
          List.flatten @@ List.map describe_edges labels;
          [ "}" ];
        ]
    in
    String.concat "\n" content
end

let dot_of_cfg ?result cfg =
  let module Worker = MakeDotPrinter (struct
    let cfg = cfg
    let result = result
  end) in
  Worker.print_graph ()
