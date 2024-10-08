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


%%
Program : Linst {$1 ++ "\tSTOP\n"}

Linst : Inst {$1}
  | Linst Inst {$1 ++ $2}

Inst : Print ';' {$1}
  | ';' { "" }

Print : print Expr {";/ print...\n" ++ $2 ++ "\tOUT\n"}

Expr : Term  { $1 } 
  | sub Expr { "\tPUSH\t" ++ "0" ++ "\n" ++ $2 ++ "\tSUB\n"  } -- TODO : negative numbers
  | Expr plus Expr  { $1 ++ $3 ++ "\tADD\n" } 
  | Expr sub Expr  { $1 ++ $3 ++ "\tSUB\n" } 

Term : Factor  { $1 } 
  | Term mul Factor  { $1 ++ $3 ++ "\tMUL\n" } 
  | Term div Factor  { $1 ++ $3 ++ "\tDIV\n" } 

Factor : integer {"\tPUSH\t" ++ (show $1) ++ "\n"}
  | lpar Expr rpar  { $2 }

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
}


