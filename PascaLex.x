{
module PascaLex (Token(..),TokenName(..),AlexPosn(..),getTPosn,getTLine,getTCol,getALine,getACol,scanTokens) where
}

%wrapper "posn"

tokens :-
  <0> $white+ ;
  <0> \; {\p _ -> TK p SEP}
  <0> [1-9][0-9]* {\p s -> TK p (INT (read s))}
  <0> 0 {\p _ -> TK p (INT 0)}
  <0> print {\p _ -> TK p PRINT}
  <0> \+ {\p _ -> TK p PLUS}
  <0> \- {\p _ -> TK p SUB}
  <0>  \*\* {\p _ -> TK p POWER}
  <0> \* {\p _ -> TK p MUL}
  <0> \/ {\p _ -> TK p DIV}
  <0> \% {\p _ -> TK p MOD}
  <0> \( {\p _ -> TK p LPAR}
  <0> \) {\p _ -> TK p RPAR}
  <0> \{\-\- {\p _ -> TK p OPENMULTILINECOMMENT}
  <0> \-\-\} {\p _ -> TK p CLOSEMULTILINECOMMENT}
  <0> \-\-.* ; -- we skip the comments
  -- TODO : skip comments zones
  <0> var {\p _ -> TK p VAR}
  <0> \>\= {\p _ -> TK p SUPERIROROREQUAL}
  <0> \> {\p _ -> TK p SUPERIROR}
  <0> \<\= {\p _ -> TK p INFERIOROREQUAL}
  <0> \< {\p _ -> TK p INFERIOR}
  <0> \=\= {\p _ -> TK p COMPAREEQUAL}
  <0> \!\= {\p _ -> TK p COMPAREDIFFERENT}
  <0> \= {\p _ -> TK p ASSIGN}
  <0> input {\p _ -> TK p IN}
  <0> if {\p _ -> TK p IF}
  <0> else {\p _ -> TK p ELSE}
  <0> while {\p _ -> TK p WHILE}
  <0> array {\p _ -> TK p ARRAY}
  <0> or {\p _ -> TK p OR}
  <0> and {\p _ -> TK p AND}
  <0> not {\p _ -> TK p NOT}
  <0> true {\p _ -> TK p TRUE}
  <0> false {\p _ -> TK p FALSE}
  <0> exit {\p _ -> TK p EXIT}
  <0> def {\p _ -> TK p DEF}
  <0> return {\p _ -> TK p RETURN}
  <0> \{ {\p _ -> TK p LEFTCURLYBRACKET}
  <0> \} {\p _ -> TK p RIGHTCURLYBRACKET}
  <0> \[ {\p _ -> TK p LEFTSQUAREDBRACKET}
  <0> \] {\p _ -> TK p RIGHTSQUAREDBRACKET}
  <0> \, {\p _ -> TK p COMMA}
  <0> [a-zA-Z][a-zA-Z0-9]* {\p s -> TK p (VARNAME s)}

{
data Token = TK AlexPosn TokenName deriving (Eq,Show)

data TokenName
  = INT Integer
  | PRINT
  | SEP
  | PLUS
  | SUB
  | MUL
  | DIV
  | MOD
  | LPAR
  | RPAR
  | COS
  | SQRT
  | SIN 
  | POWER
  | VAR
  | VARNAME String
  | ASSIGN
  | IN
  | IF 
  | ELSE
  | WHILE
  | LEFTCURLYBRACKET
  | RIGHTCURLYBRACKET
  | ARRAY
  | LEFTSQUAREDBRACKET
  | RIGHTSQUAREDBRACKET
  | COMMA
  | OR
  | AND 
  | NOT 
  | TRUE 
  | FALSE
  | EXIT
  | DEF
  | RETURN
  | SUPERIROROREQUAL
  | SUPERIROR
  | INFERIOROREQUAL
  | INFERIOR
  | COMPAREEQUAL
  | COMPAREDIFFERENT
  | OPENMULTILINECOMMENT
  | CLOSEMULTILINECOMMENT
  deriving (Eq,Show)

scanTokens = alexScanTokens

getTPosn :: Token -> AlexPosn
getTPosn (TK p _) = p

getALine :: AlexPosn -> Int
getALine (AlexPn _ l _) = l

getTLine :: Token -> Int
getTLine = getALine . getTPosn

getACol :: AlexPosn -> Int
getACol (AlexPn _ _ c) = c

getTCol :: Token -> Int
getTCol = getACol . getTPosn
}
