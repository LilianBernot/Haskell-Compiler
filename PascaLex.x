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

{
data Token = TK AlexPosn TokenName deriving (Eq,Show)

data TokenName
  = INT Integer
  | PRINT
  | SEP
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
