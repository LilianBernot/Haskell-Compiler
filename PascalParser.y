{
module PascalParser(parseProgram,ParseResult,initEtat)

where

import PascaLex
import Control.Monad.State.Lazy

}

%name parse
%tokentype { Token }
%error { parseError }
%monad {ParseResult}

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
  exit {TK _ EXIT}
  superior_or_equal {TK _ SUPERIROROREQUAL}
  superior {TK _ SUPERIROR}
  inferior_or_equal {TK _ INFERIOROREQUAL}
  inferior {TK _ INFERIOR}
  compare_equal {TK _ COMPAREEQUAL}
  compare_different {TK _ COMPAREDIFFERENT}
  open_multiline_comment {TK _ OPENMULTILINECOMMENT}
  close_multiline_comment {TK _ CLOSEMULTILINECOMMENT}

%%
Program : Linst {$1 ++ "\tSTOP\n"}

Linst : Inst {$1}
  | Linst Inst {$1 ++ $2}

Inst : Print ';' {$1}
  | ';' { "" }
  | SystemCall { $1 }
  | open_multiline_comment Linst close_multiline_comment { "" }
  | VariableDeclaration {$1}
  | input varname { push $2 ++ "\tIN\n" ++ store}
  -- push the varname, in saves value in stack -> STORE in in data
  | IfStatement {$1}
  | WhileStatement {$1}

Print : print Expr {";/ print...\n" ++ $2 ++ out}
  | print varname lsb Expr rsb {";/ print...\n" ++ getArrayElementFromIndex $2 $4 ++ load ++ out}

SystemCall : exit lpar Expr rpar { $3 ++ "\tSTOP\n"}

WhileStatement : while Expr lcb Linst rcb {
  let labelStartWhile = "labelStartWhile" ++ show(getTLine $1) ++ "Col" ++ show(getTCol $1) in
  let labelEndWhile = "labelEndWhile" ++ show(getTLine $1) ++ "Col" ++ show(getTCol $1) in
  ";/ While Loop\n" ++ labelStartWhile ++ equ ++ $2 ++ bez labelEndWhile ++ $4 ++ push labelStartWhile ++ goto ++ labelEndWhile ++ equ
}

-- For comparison we use BGZ, which, if the last elemen in the pile is > 0, we jump to else statement
-- So 
IfStatement : 
  if Expr lcb Linst rcb else lcb Linst rcb { 
    let labelIf = "labelIf" ++ show(getTLine $1) ++ "Col" ++ show(getTCol $1) in
    let labelElse = "labelElse" ++ show(getTLine $6) ++ "Col" ++ show(getTCol $6) in
    ";/ If Then Else Condition\n" ++ $2 ++ bez labelIf ++ $4 ++ push labelElse ++ goto ++ labelIf ++ equ ++ $8 ++ labelElse ++ equ 
  }
  | if Expr lcb Linst rcb { 
      let labelIf = "labelIf" ++ show(getTLine $1) ++ "Col" ++ show(getTCol $1) in
      ";/ If Then Condition\n" ++ $2 ++ bez labelIf ++ $4 ++ labelIf ++ equ 
    }

VariableDeclaration : var VariableNames {$2}
  | varname assign Expr {affectVariableValue $1 $3}
  | var varname assign Expr {declareVariable $2 ++ affectVariableValue $2 $4}
  | array varname integer {$2 ++"\tDS\t" ++ (show $3) ++ "\n"}
  | varname lsb Expr rsb assign Expr {getArrayElementFromIndex $1 $3 ++ $6 ++ store}

VariableNames : varname {declareVariable $1}
  | varname comma VariableNames { declareVariable $1 ++ $3}
  -- TODO : this is only "initialization" of variables -> add declaration with values

Boolean : false { false_bool }
  | true { true_bool }

-- False = 0, True = 1
Comparison : Expr inferior Expr { % lowerThan $1 $3 "0" }
  | Expr inferior_or_equal Expr { % lowerThan $1 $3 "1" }
  | Expr superior Expr { % greaterThan $1 $3 "0" }
  | Expr superior_or_equal Expr { % greaterThan $1 $3 "1" }
  | Expr compare_equal Expr { % compareEqual $1 $3 }
  | Expr compare_different Expr { % compareDifferent $1 $3 }
  | Expr and Expr { $1 ++ $3 ++ "\tAND\n" }
  | Expr or Expr { $1 ++ $3 ++ "\tOR\n" }
  | not Expr { push "1" ++ $2 ++ substract 
    -- 1 - number -> only not 1 is False 
    -- not is really bad when comparing none booleans
  }

Expr : Term  { $1 } 
  | Boolean { $1 }
  | Comparison { $1 }
  | sub Expr { true_bool ++ $2 ++ substract  } -- negative numbers
  | Expr plus Expr  { $1 ++ $3 ++ add } 
  | Expr sub Expr  { $1 ++ $3 ++ substract } 
  | Expr mod Expr { $1 ++ $1 ++ $3 ++ divide ++ $3 ++ multiply ++ substract }

Term : Factor  { $1 } 
  | Term mul Factor  { $1 ++ $3 ++ multiply } 
  | Term div Factor  { $1 ++ $3 ++ divide } 

Factor : integer { push (show $1)}
  | lpar Expr rpar  { $2 }
  | varname { push $1 ++ load }

{
data Etat = Etat {counter :: Integer} deriving (Eq, Show)
type ParseResult a = State Etat a
-- We change the ParseResult and it does not care as we declare the parser as monadic

incrCounter :: Etat -> Etat
incrCounter s = Etat {counter = (counter s) + 1}
initEtat :: Etat
initEtat = Etat 0

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
goto = "\tGOTO\n"
equ = "\tEQU\t*\n"
store = "\tSTORE\n"
out = "\tOUT\n"
load = "\tLOAD\n"
false_bool = push "0"
true_bool = push "1" 

declareVariable :: String -> String
declareVariable name = name ++"\tDS\t1\n"

affectVariableValue :: String -> String -> String
affectVariableValue name value = push name ++ value ++ store

getArrayElementFromIndex :: String -> String -> String
getArrayElementFromIndex array_name index = push array_name ++ index ++ add

bgz :: String -> String
bgz label = "\tBGZ\t" ++ label ++ "\n"

bez :: String -> String
bez label = "\tBEZ\t" ++ label ++ "\n"

compareDifferent :: String -> String -> ParseResult String
compareDifferent a b = do
  lower <- lowerThan a b "0"
  greater <- greaterThan a b "0"
  return (lower ++ greater ++ "\tOR\n")

compareEqual :: String -> String -> ParseResult String
compareEqual a b = do
  lower <- lowerThan b a "1"
  greater <- lowerThan a b "1"
  return (lower ++ greater ++ "\tAND\n")

greaterThan :: String -> String -> String -> ParseResult String
greaterThan a b or_equal = do
  s <- lowerThan b a or_equal
  return s

lowerThan :: String -> String -> String -> ParseResult String
lowerThan a b or_equal = do
  -- or_equal : "1" if <= if strict, "0"
  s <- get
  let labelTrue = "labelTrue_" ++ show (counter s)
  let labelFalse = "labelFalse_" ++ show (counter s)
  let b_value = b ++ push or_equal ++ add
      s' = incrCounter s
  put s'
  return ( ";/ Compare Condition\n" ++ b_value ++ a ++ substract ++ bgz labelTrue ++ push "0" ++ push labelFalse ++ goto ++ labelTrue ++ equ ++ push "1" ++ labelFalse ++ equ)
}


