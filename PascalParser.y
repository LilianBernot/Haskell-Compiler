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
  mod {TK _ MOD}
  lpar {TK _ LPAR}
  rpar {TK _ RPAR}
  cos {TK _ COS}
  sin {TK _ SIN}
  sqrt {TK _ SQRT}
  power {TK _ POWER}
  var {TK _ VAR}
  varname {TK _ (VARNAME $$)}
  array {TK _ ARRAY}
  assign {TK _ ASSIGN}
  input {TK _ IN}
  if {TK _ IF}
  else {TK _ ELSE}
  while {TK _ WHILE}
  lcb {TK _ LEFTCURLYBRACKET}
  rcb {TK _ RIGHTCURLYBRACKET}
  lsb {TK _ LEFTSQUAREDBRACKET}
  rsb {TK _ RIGHTSQUAREDBRACKET}
  comma {TK _ COMMA}
  or {TK _ OR}
  and {TK _ AND}
  not {TK _ NOT}
  true {TK _ TRUE}
  false {TK _ FALSE}
  superior_or_equal {TK _ SUPERIROROREQUAL}
  superior {TK _ SUPERIROR}
  inferior_or_equal {TK _ INFERIOROREQUAL}
  inferior {TK _ INFERIOR}
  compare_equal {TK _ COMPAREEQUAL}
  compare_different {TK _ COMPAREDIFFERENT}

%%
Program : Linst {$1 ++ "\tSTOP\n"}

Linst : Inst {$1}
  | Linst Inst {$1 ++ $2}

Inst : Print ';' {$1}
  | ';' { "" }
  | VariableDeclaration {$1}
  | input varname { push $2 ++ "\tIN\n" ++ "\tSTORE\n"}
  -- push the varname, in saves value in stack -> STORE in in data
  | IfStatement {$1}
  | WhileStatement {$1}

Print : print Expr {";/ print...\n" ++ $2 ++ "\tOUT\n"}
  | print varname lsb Expr rsb {";/ print...\n" ++ getArrayElementFromIndex $2 $4 ++ "\tLOAD\n" ++ "\tOUT\n"}

WhileStatement : while Expr lcb Linst rcb {
  let labelStartWhile = "labelStartWhile" ++ show(getTLine $1) ++ "Col" ++ show(getTCol $1) in
  let labelEndWhile = "labelEndWhile" ++ show(getTLine $1) ++ "Col" ++ show(getTCol $1) in
  ";/ While Loop\n" ++ labelStartWhile ++ "\tEQU\t*\n" ++ $2 ++ bez labelEndWhile ++ $4 ++ push labelStartWhile ++ "\tGOTO\n" ++ labelEndWhile ++ "\tEQU\t*\n"
}

IfStatement : 
  if Expr lcb Linst rcb else lcb Linst rcb { 
    let labelIf = "labelIf" ++ show(getTLine $1) ++ "Col" ++ show(getTCol $1) in
    let labelElse = "labelElse" ++ show(getTLine $6) ++ "Col" ++ show(getTCol $6) in
    ";/ If Then Else Condition\n" ++ $2 ++ bez labelElse ++ $4 ++ push labelIf ++ "\tGOTO\n" ++ labelElse ++ "\tEQU\t*\n" ++ $8 ++ labelIf ++ "\tEQU\t*\n" 
  }
  | if Expr lcb Linst rcb { 
      let labelIf = "labelIf" ++ show(getTLine $1) ++ "Col" ++ show(getTCol $1) in
      ";/ If Then Condition\n" ++ $2 ++ bez labelIf ++ $4 ++ labelIf ++ "\tEQU\t*\n" 
    }

VariableDeclaration : var VariableNames {$2}
  | varname assign Expr {affectVariableValue $1 $3}
  | var varname assign Expr {declareVariable $2 ++ affectVariableValue $2 $4}
  | array varname integer {$2 ++"\tDS\t" ++ (show $3) ++ "\n"}
  | varname lsb Expr rsb assign Expr {getArrayElementFromIndex $1 $3 ++ $6 ++ "\tSTORE\n"}

VariableNames : varname {declareVariable $1}
  | varname comma VariableNames { declareVariable $1 ++ $3}
  -- TODO : this is only "initialization" of variables -> add declaration with values

Boolean : false { push "1"}
  | true { push "0" }

Expr : Term  { $1 } 
  | Boolean { $1 }
  | sub Expr { push "0" ++ $2 ++ substract  } -- negative numbers
  | Expr plus Expr  { $1 ++ $3 ++ add } 
  | Expr sub Expr  { $1 ++ $3 ++ substract } 
  | Expr mod Expr { $1 ++ $1 ++ $3 ++ divide ++ $3 ++ multiply ++ substract }

Term : Factor  { $1 } 
  | Term mul Factor  { $1 ++ $3 ++ multiply } 
  | Term div Factor  { $1 ++ $3 ++ divide } 

Factor : integer { push (show $1)}
  | lpar Expr rpar  { $2 }
  | varname { push $1 ++ "\tLOAD\n" }

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

push :: String -> String
push string = "\tPUSH\t" ++ string ++ "\n"

-- Define small strings
add = "\tADD\n"
substract = "\tSUB\n"
divide = "\tDIV\n"
multiply = "\tMUL\n"

declareVariable :: String -> String
declareVariable name = name ++"\tDS\t1\n"

affectVariableValue :: String -> String -> String
affectVariableValue name value = push name ++ value ++ "\tSTORE\n"

getArrayElementFromIndex :: String -> String -> String
getArrayElementFromIndex array_name index = push array_name ++ index ++ add

bez :: String -> String
bez label = "\tBEZ\t" ++ label ++ "\n"
}


