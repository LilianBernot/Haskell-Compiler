module Main(main) where

import PascalParser

main :: IO ()
main = do
  input <- getContents
  putStrLn (parseProgram input)
