(*-----------------------------------------------------------------------------
 * Principles of Program Analysis - Laboratory
 *    University of Wroclaw, Institute of Computer Science
 *---------------------------------------------------------------------------*)

(* Simple library for making hierarchized command tables.
 *)

module type SCommand = sig
  val run : string array -> unit
end

type scommand = (module SCommand)

module CommandSwitch (M : sig
  val commands : (string * scommand) list
end) : SCommand = struct
  open M

  let print_help commands =
    let f (name, _) = Format.printf " - %s\n%!" name in
    Format.printf "Subcommands:\n%!";
    List.iter f commands

  let find_command desired commands argv =
    match List.assoc_opt desired commands with
    | None ->
        Format.printf "Invalid command: %s\n%!" desired;
        print_help commands
    | Some cmd ->
        let module Command = (val cmd : SCommand) in
        Command.run argv

  let run argv =
    let n = Array.length argv in
    if n < 2 then print_help commands
    else
      let name = argv.(1) in
      let subargv = Array.sub argv 1 (pred n) in
      find_command name commands subargv
end

let make_switch commands : scommand =
  let module M = struct
    let commands = commands
  end in
  let module X = CommandSwitch (M) in
  (module X : SCommand)

let run cmd =
  let module Command = (val cmd : SCommand) in
  Command.run Sys.argv

let apk_doc = "Principles of Program Analysis -- Laboratory"
let apk_version = "2019.1"
