{
(* ----------------------------------------------------------------------------
 * Principles of Program Analysis - Labolatory
 *    University of Wroclaw, Institute of Computer Science
 *---------------------------------------------------------------------------*)
  open Parser
  open Lexing
  open Common.Ast

  
  let keywords =
      [ "if",       IF
      ; "while",    WHILE
      ; "else",     ELSE
      ; "break",    BREAK
      ; "continue", CONTINUE
      ; "else",     ELSE
      ; "goto",     GOTO
      ; "skip",     SKIP
      ; "malloc",   MALLOC
      ; "null",     NULL
      ]
  
  let symbols =
      [ "+", OP_ADD
      ; "-", OP_SUB
      ; "*", OP_MUL
      ; "/", OP_DIV
      ; "(", LPARENT
      ; ")", RPARENT
      ; "{", CURLY_LPARENT
      ; "}", CURLY_RPARENT
      ; ";", SEMICOLON
      ; "=", OP_ASSIGN
      ; "==", REL_EQ
      ; "!=", REL_NE
      ; "<=", REL_LE
      ; "<", REL_LT
      ; ">", REL_GT
      ; ">=", REL_GE
      ; "!", OP_NOT
      ; ":", COLON
      ; "&", AMPERSAND
      ]
  
  let makeTable mapping =
      let h = Hashtbl.create 127 in
      List.iter (fun (str, key) -> Hashtbl.replace h str key) mapping;
      h
  
  let keywordsTable = makeTable keywords
  let symbolTable = makeTable symbols
  
  let mkIdentifier str =
      try
          Hashtbl.find keywordsTable str
      with Not_found ->
          IDENTIFIER str
  
  let lookupSymbol str =
      try
          Hashtbl.find symbolTable str
      with Not_found ->
          failwith "unknown token symbol"
  
  let handleError pos token =
      let exc = InvalidToken (mkLoc pos, token) in
      raise exc
  
  }
  
  let digit   = ['0'-'9']
  let id        = ['a'-'z' '_' 'A' - 'Z']['_' 'A' - 'Z' 'a'-'z' '0'-'9']*
  let symbols = ['(' ')' '{' '}' ';' ':' '+' '-' '*' '/' '<' '>' '=' '!' '&']
                | "!" | ":=" | "==" | "!=" | "<=" | ">="
  
  rule token = parse
      | ['\n']
      { new_line lexbuf; token lexbuf }
  
      | "//"
      { line_comment "" lexbuf }

      | [' ' '\t' '\r']
      { token lexbuf }
  
      | digit+ as num
      { INT (int_of_string num) }
  
      | "L" (digit+ as num)
      { LABEL (int_of_string num) }
  
      | id as str
      { mkIdentifier str }
  
      | symbols as symbol
      { lookupSymbol symbol }
  
      | eof
      { EOF }
  
      | _
      { handleError (Lexing.lexeme_start_p lexbuf) (Lexing.lexeme lexbuf) }

    and line_comment buff = parse
      | '\n' 
      { new_line lexbuf; token lexbuf }

      | _ 
      { line_comment (buff ^ Lexing.lexeme lexbuf) lexbuf }
