(*-----------------------------------------------------------------------------
 * Principles of Program Analysis - Laboratory
 *    University of Wroclaw, Institute of Computer Science
 *---------------------------------------------------------------------------*)

module WhileParser = Common.Parser_wrap.Make (struct
  type token = Parser.token
  type program = Ast.program

  module Lexer = Lexer
  module Parser = Parser
end)

include WhileParser
