(*-----------------------------------------------------------------------------
 * Principles of Program Analysis - Laboratory
 *    University of Wroclaw, Institute of Computer Science
 *---------------------------------------------------------------------------*)

(* This file implements front-end for the While language. Implementation of
 * each command is split into two modules. One is implementation of command
 * behaviour (e.g. SimplifyImpl), the second is command-line handling
 * (e.g. SimplifyCommand).
 *
 * The 'command table' is at end of file.
 *)

open While

module Utils = struct
  let parse file =
    match Parser_wrapped.parse_file file with
    | Ok ok -> ok
    | Error (loc, msg) ->
        failwith
        @@ Format.sprintf "%s: %s\n%!" (Common.Ast.string_of_location loc) msg

  let unstructurize = function
    | Ast.Labeled p -> p
    | Ast.Structured p ->
        p |> Simplifier.convert_to_labeled |> Simplifier.renumber_labeled
end

module SimplifyImpl = struct
  let simplify_labeled labeled_block = Simplifier.renumber_labeled labeled_block

  let simplify_structured struct_block =
    Simplifier.convert_to_labeled struct_block |> simplify_labeled

  let simplify_program = function
    | Ast.Structured p -> simplify_structured p
    | Ast.Labeled p -> simplify_labeled p

  let process source =
    Utils.parse source |> simplify_program |> Printer.string_of_labeled_program
    |> String.concat "\n"

  let run output source_file =
    let program = process source_file in
    let output = open_out output in
    output_string output program;
    output_string output "\n";
    close_out output
end

module AnalyseImpl = struct
  let print_table result = function
    | None -> ()
    | Some output ->
        let out = open_out output in
        let fmt = Format.formatter_of_out_channel out in
        let f k =
          let input, output = Hashtbl.find result k in
          Format.fprintf fmt "label '%s'\n" (Common.Ast.string_of_label k);
          Format.fprintf fmt "   in: '%s'\n" input;
          Format.fprintf fmt "  out: '%s'\n" output
        in
        let keys = Hashtbl.to_seq_keys result in
        let keys = List.of_seq keys in
        let keys = List.sort compare keys in
        List.iter f keys;
        Format.fprintf fmt "%!";
        close_out out

  let process source = Utils.parse source |> Utils.unstructurize

  let print_dot cfg result = function
    | None -> ()
    | Some output ->
        let buffer = Cfg.dot_of_cfg ~result cfg in
        let output = open_out output in
        output_string output buffer;
        output_string output "\n";
        close_out output

  let print_stats aname stats =
    let s_transfer = !(stats.Analysis.stat_transfers) in
    let s_join = !(stats.Analysis.stat_join) in
    let s_less_or_equal = !(stats.Analysis.stat_less_or_equal) in
    Format.printf "Measurements:\n";
    Format.printf " - algorithm: %s\n" aname;
    Format.printf " - number of calls to `transfer`:      %u\n" s_transfer;
    Format.printf " - number of calls to `less_or_equal`: %u\n" s_less_or_equal;
    Format.printf " - number of calls to `join`:          %u\n" s_join;
    Format.printf "%!"

  let print_footer a b stats =
    match (a, b) with
    | None, None ->
        Format.printf
          "Please use switches -t/--table or -c/--cfg to obtain analysis result.\n\
           %!";
        if not stats then
          Format.printf
            "You can also print statistics using switch -s/--stats\n%!"
    | _ -> ()

  let algorithm_registry_consistency_check requested obtained =
    if requested <> obtained then
      failwith
      @@ Format.sprintf
           "Algorithm registry is inconsistent! Requested algorithm named \
            `%s`, but obtained algorithm is named `%s`"
           requested obtained

  let analyse analysis algorithm source_file cfg_file table_file stats =
    let program = process source_file in
    let cfg = Cfg.build program in
    let mfp = Analysis_registry.lookup_analysis analysis in
    let module MFP = (val mfp : Analysis.SMonotoneFrameworkParameters) in
    let module MFP = Analysis.WrapWithMeasurements (MFP) in
    let module MFA =
      (val Analysis_registry.lookup_algorithm algorithm
          : Analysis.SMonotoneFrameworkAlgorithm)
    in
    let module MF = MFA (MFP) in
    algorithm_registry_consistency_check algorithm MF.algorithm_name;
    let result = MF.analyse program cfg in
    let result = MF.stringize result in
    if stats then print_stats MF.algorithm_name MFP.stats;
    print_dot cfg result cfg_file;
    print_table result table_file;
    print_footer cfg_file table_file stats

  let help () =
    Format.printf
      "Execute this command with switch `--help` to get more information.\n";
    Format.printf "Analyses:\n";
    List.iter (Format.printf "- %s\n") (Analysis_registry.analysis_list ());
    Format.printf "Algorithms:\n";
    List.iter (Format.printf "- %s\n") (Analysis_registry.algorithm_list ())

  let run cfg_file table_file analysis algorithm stats source_file =
    match (analysis, source_file) with
    | Some analysis, Some source_file ->
        analyse analysis algorithm source_file cfg_file table_file stats
    | _ -> help ()
end

module CfgImpl = struct
  let process source =
    Utils.parse source |> Utils.unstructurize |> Cfg.build |> Cfg.dot_of_cfg

  let run output source_file =
    let program = process source_file in
    let output = open_out output in
    output_string output program;
    output_string output "\n";
    close_out output
end

open Common.Command_hierarchy

module AnalyseCommand = struct
  open Cmdliner

  let compile table cfg analysis algorithm stats source_file =
    AnalyseImpl.run cfg table analysis algorithm stats source_file;
    0

  let table =
    let doc = "Table file" in
    Arg.(value & opt (some string) None & info [ "t"; "table" ] ~doc)

  let cfg =
    let doc = "Cfg file" in
    Arg.(value & opt (some string) None & info [ "c"; "cfg" ] ~doc)

  let algorithm =
    let doc = "Algorithm" in
    Arg.(
      value & opt string "chaotic-iteration" & info [ "a"; "algorithm" ] ~doc)

  let analysis =
    let doc = "Analysis" in
    Arg.(value & pos 0 (some string) None & info [] ~doc)

  let stats =
    let doc = "Print statistics" in
    Arg.(value & flag & info [ "s"; "stats" ] ~doc)

  let source_file =
    let doc = "Source File" in
    Arg.(value & pos 1 (some file) None & info [] ~doc)

  let cmd =
    let compile_t =
      Term.(
        const compile $ table $ cfg $ analysis $ algorithm $ stats $ source_file)
    in
    let info = Cmd.info "while-analyse" ~doc:apk_doc ~version:apk_version in
    Cmd.v info compile_t

  let main argv = exit (Cmd.eval' ~argv cmd)
  let run argv = main argv
end

module SimplifyCommand = struct
  open Cmdliner

  let compile out src =
    SimplifyImpl.run out src;
    0

  let output =
    let doc = "Output file" in
    Arg.(value & opt string "/dev/stdout" & info [ "o"; "output" ] ~doc)

  let source_file =
    let doc = "Source File" in
    Arg.(required & pos 0 (some file) None & info [] ~doc)

  let cmd =
    let compile_t = Term.(const compile $ output $ source_file) in
    let info = Cmd.info "while-simplify" ~doc:apk_doc ~version:apk_version in
    Cmd.v info compile_t

  let main argv = exit (Cmd.eval' ~argv cmd)
  let run argv = main argv
end

module CfgCommand = struct
  open Cmdliner

  let compile out src =
    CfgImpl.run out src;
    0

  let output =
    let doc = "Output file" in
    Arg.(value & opt string "/dev/stdout" & info [ "o"; "output" ] ~doc)

  let source_file =
    let doc = "Source File" in
    Arg.(required & pos 0 (some file) None & info [] ~doc)

  let cmd =
    let compile_t = Term.(const compile $ output $ source_file) in
    let info = Cmd.info "while-cfg" ~doc:apk_doc ~version:apk_version in
    Cmd.v info compile_t

  let main argv = exit (Cmd.eval' ~argv cmd)
  let run argv = main argv
end

(* Command table *)
let command =
  make_switch
    [
      ("analyse", (module AnalyseCommand : SCommand));
      ("simplify", (module SimplifyCommand : SCommand));
      ("cfg", (module CfgCommand : SCommand));
    ]
