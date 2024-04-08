(*-----------------------------------------------------------------------------
 * Principles of Program Analysis - Laboratory
 *    University of Wroclaw, Institute of Computer Science
 *---------------------------------------------------------------------------*)
open Common.Ast
open Ast

module Implementation () = struct
  let label_counter = ref 0
  let reset_label_counter () = label_counter := 0

  let alloc_label () =
    let l = !label_counter in
    incr label_counter;
    Label l

  let get_loop_label loc = function
    | None ->
        failwith
        @@ Format.sprintf "%s: this construct should be used only inside a loop"
             (string_of_location loc)
    | Some l -> l

  (* This function could have problems with very deep nestings of blocks.
     To overcome this problem rewrite function into CPS-type *)
  let rec sequentalize_instruction label ?loop_header ?loop_after = function
    | SSTMT_Assign { loc; lhs; rhs } ->
        [ (label, STMT_Assign { loc; lhs; rhs }) ]
    | SSTMT_Skip { loc } -> [ (label, STMT_Skip { loc }) ]
    | SSTMT_Break { loc } ->
        [ (label, STMT_Goto { loc; target = get_loop_label loc loop_after }) ]
    | SSTMT_Continue { loc } ->
        [ (label, STMT_Goto { loc; target = get_loop_label loc loop_header }) ]
    | SSTMT_While { loc; cond; body } ->
        let new_loop_header = label in
        let new_loop_after = alloc_label () in
        let cond = BEXPR_UnOp { op = UNOP_Not; sub = cond } in
        let header_instruction =
          STMT_IfGoto { loc; cond; target = new_loop_after }
        in
        List.concat
          [
            [ (new_loop_header, header_instruction) ];
            sequentalize_instructions (alloc_label ())
              ~loop_header:new_loop_header ~loop_after:new_loop_after body;
            [ (alloc_label (), STMT_Goto { loc; target = new_loop_header }) ];
            [ (new_loop_after, STMT_Skip { loc }) ];
          ]
    | SSTMT_If { loc; cond; then_branch; else_branch = None } ->
        let cond = BEXPR_UnOp { op = UNOP_Not; sub = cond } in
        let if_after = alloc_label () in
        let header_instruction = STMT_IfGoto { loc; cond; target = if_after } in
        List.concat
          [
            [ (label, header_instruction) ];
            sequentalize_instructions (alloc_label ()) ?loop_header ?loop_after
              then_branch;
            [ (if_after, STMT_Skip { loc }) ];
          ]
    | SSTMT_If { loc; cond; then_branch; else_branch = Some else_branch } ->
        let cond = BEXPR_UnOp { op = UNOP_Not; sub = cond } in
        let if_after = alloc_label () in
        let if_else = alloc_label () in
        let header_instruction = STMT_IfGoto { loc; cond; target = if_else } in
        List.concat
          [
            [ (label, header_instruction) ];
            sequentalize_instructions (alloc_label ()) ?loop_header ?loop_after
              then_branch;
            [ (alloc_label (), STMT_Goto { loc; target = if_after }) ];
            sequentalize_instructions if_else ?loop_header ?loop_after
              else_branch;
            [ (if_after, STMT_Skip { loc }) ];
          ]

  and sequentalize_instructions label ?loop_header ?loop_after xs =
    let f (label, xs) i =
      let translated =
        sequentalize_instruction label ?loop_header ?loop_after i
      in
      let label = alloc_label () in
      (label, translated :: xs)
    in
    List.concat @@ List.rev @@ snd @@ List.fold_left f (label, []) xs

  let sequentalize program = sequentalize_instructions (alloc_label ()) program
  let simplify program = sequentalize program

  let renumber program =
    reset_label_counter ();
    let h = Hashtbl.create 513 in
    let scan (l, _) =
      let l' = alloc_label () in
      Hashtbl.replace h l l'
    in
    List.iter scan program;

    let find l =
      try Hashtbl.find h l
      with Not_found ->
        failwith @@ Format.sprintf "unknown label: %s" (string_of_label l)
    in
    let assign = function
      | STMT_Goto { loc; target } -> STMT_Goto { loc; target = find target }
      | STMT_IfGoto { loc; cond; target } ->
          STMT_IfGoto { loc; cond; target = find target }
      | s -> s
    in

    let assign (l, s) =
      let l = find l in
      (l, assign s)
    in
    List.map assign program
end

let renumber_labeled program =
  let module Instance = Implementation () in
  Instance.renumber program

let convert_to_labeled program =
  let module Instance = Implementation () in
  Instance.simplify program
