(*-----------------------------------------------------------------------------
 * Principles of Program Analysis - Laboratory
 *    University of Wroclaw, Institute of Computer Science
 *---------------------------------------------------------------------------*)

(* Glue code for generated lexers and parsers.
 *)

module type SParserLexer = sig
  type token
  type program

  module Lexer : sig
    val token : Lexing.lexbuf -> token
  end

  module Parser : sig
    exception Error

    val file : (Lexing.lexbuf -> token) -> Lexing.lexbuf -> program
  end
end

module Make (PL : SParserLexer) = struct
  module Internal = struct
    let open_lexbuf file =
      let channel = open_in file in
      let lexbuf = Lexing.from_channel channel in
      lexbuf.Lexing.lex_curr_p <-
        { lexbuf.Lexing.lex_curr_p with Lexing.pos_fname = file };
      lexbuf

    let parse lexbuf =
      try
        let token = PL.Lexer.token in
        Ok (PL.Parser.file token lexbuf)
      with
      | PL.Parser.Error ->
          let loc = Ast.mkLoc lexbuf.Lexing.lex_curr_p in
          let src = Lexing.lexeme lexbuf in
          let s =
            if String.length src > 0 then
              Printf.sprintf "unexpected token: %s" src
            else Printf.sprintf "unexpected end"
          in
          Error (loc, Format.sprintf "syntax error: %s" s)
      | Ast.InvalidToken (loc, str) ->
          let s = Printf.sprintf "invalid token: %s" str in
          Error (loc, Format.sprintf "syntax error: %s" s)

    let parse_file f = parse (open_lexbuf f)
  end

  let parse_file = Internal.parse_file
end
