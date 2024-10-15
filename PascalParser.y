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
  open_multiline_comment {TK _ OPENMULTILINECOMMENT}
  close_multiline_comment {TK _ CLOSEMULTILINECOMMENT}

%%
Program : Linst {$1 ++ "\tSTOP\n"}

Linst : Inst {$1}
  | Linst Inst {$1 ++ $2}

Inst : Print ';' {$1}
  | ';' { "" }
  | open_multiline_comment Linst close_multiline_comment { "" }
  | VariableDeclaration {$1}
  | input varname { push $2 ++ "\tIN\n" ++ store}
  -- push the varname, in saves value in stack -> STORE in in data
  | IfStatement {$1}
  | WhileStatement {$1}

Print : print Expr {";/ print...\n" ++ $2 ++ out}
  | print varname lsb Expr rsb {";/ print...\n" ++ getArrayElementFromIndex $2 $4 ++ load ++ out}

WhileStatement : while Expr lcb Linst rcb {
  let labelStartWhile = "labelStartWhile" ++ show(getTLine $1) ++ "Col" ++ show(getTCol $1) in
  let labelEndWhile = "labelEndWhile" ++ show(getTLine $1) ++ "Col" ++ show(getTCol $1) in
  ";/ While Loop\n" ++ labelStartWhile ++ equ ++ $2 ++ bgz labelEndWhile ++ $4 ++ push labelStartWhile ++ goto ++ labelEndWhile ++ equ
}

-- For comparison we use BGZ, which, if the last elemen in the pile is > 0, we jump to else statement
-- So 
IfStatement : 
  if Expr lcb Linst rcb else lcb Linst rcb { 
    let labelIf = "labelIf" ++ show(getTLine $1) ++ "Col" ++ show(getTCol $1) in
    let labelElse = "labelElse" ++ show(getTLine $6) ++ "Col" ++ show(getTCol $6) in
    ";/ If Then Else Condition\n" ++ $2 ++ bgz labelElse ++ $4 ++ push labelIf ++ goto ++ labelElse ++ equ ++ $8 ++ labelIf ++ equ 
  }
  | if Expr lcb Linst rcb { 
      let labelIf = "labelIf" ++ show(getTLine $1) ++ "Col" ++ show(getTCol $1) in
      ";/ If Then Condition\n" ++ $2 ++ bgz labelIf ++ $4 ++ labelIf ++ equ 
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

BooleanComparison : true and true { true_bool }
  | true and false { false_bool}
  | false and true { false_bool}
  | false and false { false_bool}
  | true or true { true_bool }
  | true or false { true_bool }
  | false or true { true_bool }
  | false or false { false_bool}
  | not true { false_bool}
  | not false { true_bool }

-- False = 0, True = 1
Comparison : Expr inferior Expr { 
      ";/ Compare Inferior Condition\n" ++ compareInf $1 $3 $2
      }
    | Expr superior Expr { 
      ";/ Compare Superior Condition\n" ++ compareInf $3 $1 $2
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
goto = "\tGOTO\n"
equ = "\tEQU\t*\n"
store = "\tSTORE\n"
out = "\tOUT\n"
load = "\tLOAD\n"
false_bool = push "1"
true_bool = push "0" 

createLabelTrue :: Token -> String
createLabelTrue token = "labelTrue" ++ show(getTLine token) ++ "Col" ++ show(getTCol token)

createLabelFalse :: Token -> String
createLabelFalse token = "labelFalse" ++ show(getTLine token) ++ "Col" ++ show(getTCol token)

declareVariable :: String -> String
declareVariable name = name ++"\tDS\t1\n"

affectVariableValue :: String -> String -> String
affectVariableValue name value = push name ++ value ++ store

getArrayElementFromIndex :: String -> String -> String
getArrayElementFromIndex array_name index = push array_name ++ index ++ add

bez :: String -> String
bez label = "\tBEZ\t" ++ label ++ "\n"

bgz :: String -> String
bgz label = "\tBGZ\t" ++ label ++ "\n"

-- | Compares two strings (a and b) based on a provided comparator token.
-- 
--   Parameters:
--     a          - The first string to compare.
--     b          - The second string to compare.
--     comparator - A token representing the comparison operator to create the labels.
-- 
--   Returns:
--     A string that contains a sequence of instructions generated 
--     based on the result of comparing `a` and `b` using the `comparator`.
compareInf :: String -> String -> Token -> String
compareInf a b comparator = 
      let labelTrue = createLabelTrue comparator in
      let labelFalse = createLabelFalse comparator in
      b ++ a ++ substract ++ bgz labelTrue ++ push "0" ++ push labelFalse ++ goto ++ labelTrue ++ equ ++ push "1" ++ labelFalse ++ equ
}


