{
module PascalParser(parseProgram,ParseResult)

where

import PascaLex

}

%name parse
%tokentype { Token }
%error { parseError }

%token
  print {TK _ PRINT}
  ';' {TK _ SEP}
  integer {TK _ (INT $$)}
  plus {TK _ PLUS}
  sub {TK _ SUB}
  mul {TK _ MUL}
  div {TK _ DIV}
  lpar {TK _ LPAR}
  rpar {TK _ RPAR}
  cos {TK _ COS}
  sin {TK _ SIN}
  sqrt {TK _ SQRT}
  power {TK _ POWER}
  var {TK _ VAR}
  varname {TK _ (VARNAME $$)}
  assign {TK _ ASSIGN}
  input {TK _ IN}
  if {TK _ IF}
  else {TK _ ELSE}
  lcb {TK _ LEFTCURLYBRACKET}
  rcb {TK _ RIGHTCURLYBRACKET}
  

%%
Program : Linst {$1 ++ "\tSTOP\n"}

Linst : Inst {$1}
  | Linst Inst {$1 ++ $2}

Inst : Print ';' {$1}
  | ';' { "" }
  | VariableDeclaration {$1}
  | input varname { "\tPUSH\t" ++ $2 ++ "\n\tIN\n" ++ "\tSTORE\n"}
  -- PUSH the varname, IN saves value in stack -> STORE in in data
  | IfStatement {$1}

Print : print Expr {";/ print...\n" ++ $2 ++ "\tOUT\n"}

IfStatement : 
  if Expr lcb Linst rcb else lcb Linst rcb { 
    let labelIf = "labelIf" ++ show(getTLine $1) ++ "Col" ++ show(getTCol $1) in
    let labelElse = "labelElse" ++ show(getTLine $6) ++ "Col" ++ show(getTCol $6) in
    ";/ If Then Else Condition\n" ++ $2 ++ "\tBEZ\t" ++ labelElse ++ "\n" ++ $4 ++ "\tPUSH\t" ++ labelIf ++ "\n" ++ "\tGOTO\n" ++ labelElse ++ "\tEQU\t*\n" ++ $8 ++ labelIf ++ "\tEQU\t*\n" 
  }
  | if Expr lcb Linst rcb { 
      let labelIf = "labelIf" ++ show(getTLine $1) ++ "Col" ++ show(getTCol $1) in
      ";/ If Then Condition\n" ++ $2 ++ "\tBEZ\t" ++ labelIf ++ "\n" ++ $4 ++ labelIf ++ "\tEQU\t*\n" 
    }

VariableDeclaration : var varname {declareVariable $2}
  | varname assign Expr {affectVariableValue $1 $3}
  | var varname assign Expr {declareVariable $2 ++ affectVariableValue $2 $4}

Expr : Term  { $1 } 
  | sub Expr { "\tPUSH\t" ++ "0" ++ "\n" ++ $2 ++ "\tSUB\n"  } -- negative numbers
  | Expr plus Expr  { $1 ++ $3 ++ "\tADD\n" } 
  | Expr sub Expr  { $1 ++ $3 ++ "\tSUB\n" } 

Term : Factor  { $1 } 
  | Term mul Factor  { $1 ++ $3 ++ "\tMUL\n" } 
  | Term div Factor  { $1 ++ $3 ++ "\tDIV\n" } 

Factor : integer {"\tPUSH\t" ++ (show $1) ++ "\n"}
  | lpar Expr rpar  { $2 }
  | varname { "\tPUSH\t" ++ $1 ++ "\n" ++ "\tLOAD\n" }

{

{-
 Un type "stupide" -- ParseResult String est un synonyme de String.
    On a envie de remplacer "ParseResult a" par "a" directement,
    mais nous l'étendrons par la suite (questions 12 et suivantes)
-}
  
type ParseResult a = a

parseProgram :: String -> ParseResult String
parseProgram = parse . scanTokens

parseError :: [Token] -> ParseResult a
parseError [] = error "Parse error at the end of input"
parseError (h:_) = error $ "Parse error at line " ++ show (getTLine h) ++ ", column " ++ show (getTCol h) ++ ", on token " ++ show h

declareVariable :: String -> String
declareVariable name = name ++"\tDS\t1\n"

affectVariableValue :: String -> String -> String
affectVariableValue name value = "\tPUSH\t" ++ name ++"\n" ++ value ++ "\tSTORE\n"
}


