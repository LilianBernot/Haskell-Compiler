{-# OPTIONS_GHC -w #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MagicHash #-}
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE NoStrictData #-}
#if __GLASGOW_HASKELL__ >= 710
{-# LANGUAGE PartialTypeSignatures #-}
#endif
module PascalParser(parseProgram,ParseResult)

where

import PascaLex
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import qualified GHC.Exts as Happy_GHC_Exts
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 2.0.1

data HappyAbsSyn t4 t5 t6 t7 t8 t9 t10 t11 t12 t13 t14
        = HappyTerminal (Token)
        | HappyErrorToken Prelude.Int
        | HappyAbsSyn4 t4
        | HappyAbsSyn5 t5
        | HappyAbsSyn6 t6
        | HappyAbsSyn7 t7
        | HappyAbsSyn8 t8
        | HappyAbsSyn9 t9
        | HappyAbsSyn10 t10
        | HappyAbsSyn11 t11
        | HappyAbsSyn12 t12
        | HappyAbsSyn13 t13
        | HappyAbsSyn14 t14

happyExpList :: HappyAddr
happyExpList = HappyA# "\x00\xc0\x00\x70\x0b\x00\x00\x03\xc0\x2d\x00\x00\x0c\x00\xb7\x00\x00\x00\x00\x00\x00\x00\x80\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x45\x20\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x20\x10\x00\x00\x00\x20\x00\x00\x00\x00\x80\x00\x00\x00\x50\x04\x02\x00\x00\x40\x11\x08\x00\x00\x00\x00\x00\x00\x00\x00\x98\x00\x40\x00\x00\x80\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x14\x81\x00\x00\x00\x50\x04\x02\x00\x00\x00\x00\x00\x00\x00\x00\x26\x00\x10\x00\x00\x00\x00\x00\x00\x00\x10\x00\x00\x00\x00\x40\x11\x08\x00\x00\x00\x45\x20\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x10\x00\x80\x09\x00\x00\x00\x00\x00\x00\x40\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x40\x11\x08\x00\x00\x00\x45\x20\x00\x00\x00\x14\x81\x00\x00\x00\x50\x04\x02\x00\x00\x40\x11\x08\x00\x00\x00\x00\x20\x00\x00\x00\x98\x00\x00\x02\x00\x60\x02\x00\x00\x00\x00\x00\x00\x00\x00\xc0\x00\x70\x0b\x00\x00\x98\x02\x00\x00\x00\x00\x00\x00\x00\x00\x40\x10\x08\x00\x00\x00\x41\x20\x00\x00\x00\x03\xc0\x2d\x00\x00\x0c\x00\xb7\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0c\x00\xb7\x02\x00\x00\x00\x20\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\x00\x60\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x60\x02\x00\x08\x00\x00\x00\x00\x00\x00\x00\x45\x20\x00\x00\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\x00\x00\x26\x00\x00\x00\x00\x03\xc0\x2d\x00\x00\x0c\x00\xb7\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parse","Program","Linst","Inst","Print","WhileStatement","IfStatement","VariableDeclaration","VariableNames","Expr","Term","Factor","print","';'","integer","plus","sub","mul","div","mod","lpar","rpar","cos","sin","sqrt","power","var","varname","array","assign","input","if","else","while","lcb","rcb","lsb","rsb","comma","%eof"]
        bit_start = st               Prelude.* 42
        bit_end   = (st Prelude.+ 1) Prelude.* 42
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..41]
        token_strs_expected = Prelude.concatMap f bits_indexed
        f (Prelude.False, _) = []
        f (Prelude.True, nr) = [token_strs Prelude.!! nr]

happyActOffsets :: HappyAddr
happyActOffsets = HappyA# "\x2e\x00\x00\x00\x2e\x00\x00\x00\x2e\x00\x00\x00\x00\x00\x00\x00\x0c\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x45\x00\x00\x00\x00\x00\x00\x00\x08\x00\x00\x00\x10\x00\x00\x00\x18\x00\x00\x00\x28\x00\x00\x00\x4a\x00\x00\x00\x4a\x00\x00\x00\xf7\xff\xff\xff\x29\x00\x00\x00\x25\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x4a\x00\x00\x00\x4a\x00\x00\x00\x00\x00\x00\x00\x41\x00\x00\x00\x00\x00\x00\x00\x1d\x00\x00\x00\x4a\x00\x00\x00\x4a\x00\x00\x00\x00\x00\x00\x00\xef\xff\xff\xff\x7b\x00\x00\x00\x1c\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x4a\x00\x00\x00\x4a\x00\x00\x00\x4a\x00\x00\x00\x4a\x00\x00\x00\x4a\x00\x00\x00\x2a\x00\x00\x00\x03\x00\x00\x00\x7b\x00\x00\x00\x00\x00\x00\x00\x2e\x00\x00\x00\x4c\x00\x00\x00\x7b\x00\x00\x00\x06\x00\x00\x00\x06\x00\x00\x00\x2e\x00\x00\x00\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0b\x00\x00\x00\x31\x00\x00\x00\x00\x00\x00\x00\x2c\x00\x00\x00\x7b\x00\x00\x00\x7b\x00\x00\x00\x7b\x00\x00\x00\x7b\x00\x00\x00\x22\x00\x00\x00\x00\x00\x00\x00\x4a\x00\x00\x00\x36\x00\x00\x00\x00\x00\x00\x00\x35\x00\x00\x00\x7b\x00\x00\x00\x2e\x00\x00\x00\x23\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyGotoOffsets :: HappyAddr
happyGotoOffsets = HappyA# "\x5b\x00\x00\x00\x61\x00\x00\x00\x78\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xfc\xff\xff\xff\x00\x00\x00\x00\x4b\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x7c\x00\x00\x00\x7f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x82\x00\x00\x00\x85\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x88\x00\x00\x00\x8b\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x8e\x00\x00\x00\x91\x00\x00\x00\x94\x00\x00\x00\x97\x00\x00\x00\x9a\x00\x00\x00\x50\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x67\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x4f\x00\x00\x00\x77\x00\x00\x00\x6d\x00\x00\x00\x78\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x78\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x9d\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x73\x00\x00\x00\x78\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyAdjustOffset :: Happy_GHC_Exts.Int# -> Happy_GHC_Exts.Int#
happyAdjustOffset off = off

happyDefActions :: HappyAddr
happyDefActions = HappyA# "\x00\x00\x00\x00\x00\x00\x00\x00\xfe\xff\xff\xff\xfd\xff\xff\xff\x00\x00\x00\x00\xf6\xff\xff\xff\xf7\xff\xff\xff\xf9\xff\xff\xff\x00\x00\x00\x00\xfa\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xe9\xff\xff\xff\xe4\xff\xff\xff\xe1\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\xdf\xff\xff\xff\x00\x00\x00\x00\xf8\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xf0\xff\xff\xff\xeb\xff\xff\xff\xf5\xff\xff\xff\xdf\xff\xff\xff\xfb\xff\xff\xff\xfc\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xef\xff\xff\xff\xed\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\xe8\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xe2\xff\xff\xff\xe3\xff\xff\xff\xe0\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\xea\xff\xff\xff\xeb\xff\xff\xff\xee\xff\xff\xff\xe5\xff\xff\xff\xe6\xff\xff\xff\xe7\xff\xff\xff\x00\x00\x00\x00\xf4\xff\xff\xff\x00\x00\x00\x00\xf1\xff\xff\xff\xf3\xff\xff\xff\x00\x00\x00\x00\xec\xff\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\xf2\xff\xff\xff"#

happyCheck :: HappyAddr
happyCheck = HappyA# "\xff\xff\xff\xff\x12\x00\x00\x00\x01\x00\x00\x00\x02\x00\x00\x00\x08\x00\x00\x00\x09\x00\x00\x00\x0a\x00\x00\x00\x04\x00\x00\x00\x05\x00\x00\x00\x03\x00\x00\x00\x1b\x00\x00\x00\x08\x00\x00\x00\x01\x00\x00\x00\x02\x00\x00\x00\x02\x00\x00\x00\x09\x00\x00\x00\x0f\x00\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x1c\x00\x00\x00\x13\x00\x00\x00\x14\x00\x00\x00\x10\x00\x00\x00\x16\x00\x00\x00\x10\x00\x00\x00\x18\x00\x00\x00\x0f\x00\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x1a\x00\x00\x00\x13\x00\x00\x00\x14\x00\x00\x00\x03\x00\x00\x00\x16\x00\x00\x00\x12\x00\x00\x00\x18\x00\x00\x00\x01\x00\x00\x00\x02\x00\x00\x00\x04\x00\x00\x00\x05\x00\x00\x00\x10\x00\x00\x00\x19\x00\x00\x00\x08\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x04\x00\x00\x00\x05\x00\x00\x00\x01\x00\x00\x00\x02\x00\x00\x00\x08\x00\x00\x00\x0f\x00\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x19\x00\x00\x00\x13\x00\x00\x00\x14\x00\x00\x00\x10\x00\x00\x00\x16\x00\x00\x00\x10\x00\x00\x00\x18\x00\x00\x00\x1a\x00\x00\x00\x0f\x00\x00\x00\x10\x00\x00\x00\x11\x00\x00\x00\x17\x00\x00\x00\x13\x00\x00\x00\x14\x00\x00\x00\x12\x00\x00\x00\x16\x00\x00\x00\x04\x00\x00\x00\x05\x00\x00\x00\x1b\x00\x00\x00\x03\x00\x00\x00\x08\x00\x00\x00\x05\x00\x00\x00\x15\x00\x00\x00\x17\x00\x00\x00\x03\x00\x00\x00\x09\x00\x00\x00\x05\x00\x00\x00\x04\x00\x00\x00\x05\x00\x00\x00\x07\x00\x00\x00\x09\x00\x00\x00\x08\x00\x00\x00\x10\x00\x00\x00\x0a\x00\x00\x00\x07\x00\x00\x00\x17\x00\x00\x00\x0a\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00\x00\x01\x00\x00\x00\x02\x00\x00\x00\x03\x00\x00\x00\x04\x00\x00\x00\x05\x00\x00\x00\x06\x00\x00\x00\x01\x00\x00\x00\x02\x00\x00\x00\x03\x00\x00\x00\x04\x00\x00\x00\x05\x00\x00\x00\x06\x00\x00\x00\x01\x00\x00\x00\x02\x00\x00\x00\x03\x00\x00\x00\x04\x00\x00\x00\x05\x00\x00\x00\x06\x00\x00\x00\x01\x00\x00\x00\x02\x00\x00\x00\x03\x00\x00\x00\x04\x00\x00\x00\x05\x00\x00\x00\x06\x00\x00\x00\x01\x00\x00\x00\x02\x00\x00\x00\x03\x00\x00\x00\x04\x00\x00\x00\x05\x00\x00\x00\x06\x00\x00\x00\x02\x00\x00\x00\x03\x00\x00\x00\x04\x00\x00\x00\x05\x00\x00\x00\x06\x00\x00\x00\x04\x00\x00\x00\x05\x00\x00\x00\x0a\x00\x00\x00\xff\xff\xff\xff\x08\x00\x00\x00\x08\x00\x00\x00\x09\x00\x00\x00\x0a\x00\x00\x00\x08\x00\x00\x00\x09\x00\x00\x00\x0a\x00\x00\x00\x08\x00\x00\x00\x09\x00\x00\x00\x0a\x00\x00\x00\x08\x00\x00\x00\x09\x00\x00\x00\x0a\x00\x00\x00\x08\x00\x00\x00\x09\x00\x00\x00\x0a\x00\x00\x00\x08\x00\x00\x00\x09\x00\x00\x00\x0a\x00\x00\x00\x08\x00\x00\x00\x09\x00\x00\x00\x0a\x00\x00\x00\x08\x00\x00\x00\x09\x00\x00\x00\x0a\x00\x00\x00\x08\x00\x00\x00\x09\x00\x00\x00\x0a\x00\x00\x00\x08\x00\x00\x00\x09\x00\x00\x00\x0a\x00\x00\x00\x08\x00\x00\x00\x09\x00\x00\x00\x0a\x00\x00\x00\x08\x00\x00\x00\x09\x00\x00\x00\x0a\x00\x00\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff"#

happyTable :: HappyAddr
happyTable = HappyA# "\x00\x00\x00\x00\x28\x00\x00\x00\x09\x00\x00\x00\x0a\x00\x00\x00\x1f\x00\x00\x00\x12\x00\x00\x00\x13\x00\x00\x00\x25\x00\x00\x00\x26\x00\x00\x00\x15\x00\x00\x00\x29\x00\x00\x00\x27\x00\x00\x00\x09\x00\x00\x00\x0a\x00\x00\x00\x22\x00\x00\x00\x17\x00\x00\x00\x0b\x00\x00\x00\x0c\x00\x00\x00\x0d\x00\x00\x00\xff\xff\xff\xff\x0e\x00\x00\x00\x0f\x00\x00\x00\x18\x00\x00\x00\x10\x00\x00\x00\x1f\x00\x00\x00\x43\x00\x00\x00\x0b\x00\x00\x00\x0c\x00\x00\x00\x0d\x00\x00\x00\x38\x00\x00\x00\x0e\x00\x00\x00\x0f\x00\x00\x00\x2c\x00\x00\x00\x10\x00\x00\x00\x1c\x00\x00\x00\x42\x00\x00\x00\x09\x00\x00\x00\x0a\x00\x00\x00\x25\x00\x00\x00\x26\x00\x00\x00\x1b\x00\x00\x00\x1d\x00\x00\x00\x27\x00\x00\x00\x30\x00\x00\x00\x31\x00\x00\x00\x25\x00\x00\x00\x26\x00\x00\x00\x09\x00\x00\x00\x0a\x00\x00\x00\x27\x00\x00\x00\x0b\x00\x00\x00\x0c\x00\x00\x00\x0d\x00\x00\x00\x24\x00\x00\x00\x0e\x00\x00\x00\x0f\x00\x00\x00\x1a\x00\x00\x00\x10\x00\x00\x00\x3a\x00\x00\x00\x48\x00\x00\x00\x40\x00\x00\x00\x0b\x00\x00\x00\x0c\x00\x00\x00\x0d\x00\x00\x00\x32\x00\x00\x00\x0e\x00\x00\x00\x0f\x00\x00\x00\x41\x00\x00\x00\x10\x00\x00\x00\x25\x00\x00\x00\x26\x00\x00\x00\x29\x00\x00\x00\x15\x00\x00\x00\x27\x00\x00\x00\x16\x00\x00\x00\x44\x00\x00\x00\x46\x00\x00\x00\x15\x00\x00\x00\x17\x00\x00\x00\x16\x00\x00\x00\x25\x00\x00\x00\x26\x00\x00\x00\x1d\x00\x00\x00\x17\x00\x00\x00\x27\x00\x00\x00\x21\x00\x00\x00\x36\x00\x00\x00\x38\x00\x00\x00\x2d\x00\x00\x00\x34\x00\x00\x00\x18\x00\x00\x00\x10\x00\x00\x00\x02\x00\x00\x00\x03\x00\x00\x00\x04\x00\x00\x00\x05\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x02\x00\x00\x00\x03\x00\x00\x00\x04\x00\x00\x00\x05\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x36\x00\x00\x00\x03\x00\x00\x00\x04\x00\x00\x00\x05\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x32\x00\x00\x00\x03\x00\x00\x00\x04\x00\x00\x00\x05\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x46\x00\x00\x00\x03\x00\x00\x00\x04\x00\x00\x00\x05\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x22\x00\x00\x00\x04\x00\x00\x00\x05\x00\x00\x00\x06\x00\x00\x00\x07\x00\x00\x00\x25\x00\x00\x00\x26\x00\x00\x00\x33\x00\x00\x00\x00\x00\x00\x00\x27\x00\x00\x00\x18\x00\x00\x00\x12\x00\x00\x00\x13\x00\x00\x00\x11\x00\x00\x00\x12\x00\x00\x00\x13\x00\x00\x00\x2e\x00\x00\x00\x12\x00\x00\x00\x13\x00\x00\x00\x2d\x00\x00\x00\x12\x00\x00\x00\x13\x00\x00\x00\x2a\x00\x00\x00\x12\x00\x00\x00\x13\x00\x00\x00\x29\x00\x00\x00\x12\x00\x00\x00\x13\x00\x00\x00\x3e\x00\x00\x00\x12\x00\x00\x00\x13\x00\x00\x00\x3d\x00\x00\x00\x12\x00\x00\x00\x13\x00\x00\x00\x3c\x00\x00\x00\x12\x00\x00\x00\x13\x00\x00\x00\x3b\x00\x00\x00\x12\x00\x00\x00\x13\x00\x00\x00\x3a\x00\x00\x00\x12\x00\x00\x00\x13\x00\x00\x00\x44\x00\x00\x00\x12\x00\x00\x00\x13\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyReduceArr = Happy_Data_Array.array (1, 32) [
        (1 , happyReduce_1),
        (2 , happyReduce_2),
        (3 , happyReduce_3),
        (4 , happyReduce_4),
        (5 , happyReduce_5),
        (6 , happyReduce_6),
        (7 , happyReduce_7),
        (8 , happyReduce_8),
        (9 , happyReduce_9),
        (10 , happyReduce_10),
        (11 , happyReduce_11),
        (12 , happyReduce_12),
        (13 , happyReduce_13),
        (14 , happyReduce_14),
        (15 , happyReduce_15),
        (16 , happyReduce_16),
        (17 , happyReduce_17),
        (18 , happyReduce_18),
        (19 , happyReduce_19),
        (20 , happyReduce_20),
        (21 , happyReduce_21),
        (22 , happyReduce_22),
        (23 , happyReduce_23),
        (24 , happyReduce_24),
        (25 , happyReduce_25),
        (26 , happyReduce_26),
        (27 , happyReduce_27),
        (28 , happyReduce_28),
        (29 , happyReduce_29),
        (30 , happyReduce_30),
        (31 , happyReduce_31),
        (32 , happyReduce_32)
        ]

happy_n_terms = 29 :: Prelude.Int
happy_n_nonterms = 11 :: Prelude.Int

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_1 = happySpecReduce_1  0# happyReduction_1
happyReduction_1 (HappyAbsSyn5  happy_var_1)
         =  HappyAbsSyn4
                 (happy_var_1 ++ "\tSTOP\n"
        )
happyReduction_1 _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_2 = happySpecReduce_1  1# happyReduction_2
happyReduction_2 (HappyAbsSyn6  happy_var_1)
         =  HappyAbsSyn5
                 (happy_var_1
        )
happyReduction_2 _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_3 = happySpecReduce_2  1# happyReduction_3
happyReduction_3 (HappyAbsSyn6  happy_var_2)
        (HappyAbsSyn5  happy_var_1)
         =  HappyAbsSyn5
                 (happy_var_1 ++ happy_var_2
        )
happyReduction_3 _ _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_4 = happySpecReduce_2  2# happyReduction_4
happyReduction_4 _
        (HappyAbsSyn7  happy_var_1)
         =  HappyAbsSyn6
                 (happy_var_1
        )
happyReduction_4 _ _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_5 = happySpecReduce_1  2# happyReduction_5
happyReduction_5 _
         =  HappyAbsSyn6
                 (""
        )

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_6 = happySpecReduce_1  2# happyReduction_6
happyReduction_6 (HappyAbsSyn10  happy_var_1)
         =  HappyAbsSyn6
                 (happy_var_1
        )
happyReduction_6 _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_7 = happySpecReduce_2  2# happyReduction_7
happyReduction_7 (HappyTerminal (TK _ (VARNAME happy_var_2)))
        _
         =  HappyAbsSyn6
                 (push happy_var_2 ++ "\tIN\n" ++ "\tSTORE\n"
        )
happyReduction_7 _ _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_8 = happySpecReduce_1  2# happyReduction_8
happyReduction_8 (HappyAbsSyn9  happy_var_1)
         =  HappyAbsSyn6
                 (happy_var_1
        )
happyReduction_8 _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_9 = happySpecReduce_1  2# happyReduction_9
happyReduction_9 (HappyAbsSyn8  happy_var_1)
         =  HappyAbsSyn6
                 (happy_var_1
        )
happyReduction_9 _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_10 = happySpecReduce_2  3# happyReduction_10
happyReduction_10 (HappyAbsSyn12  happy_var_2)
        _
         =  HappyAbsSyn7
                 (";/ print...\n" ++ happy_var_2 ++ "\tOUT\n"
        )
happyReduction_10 _ _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_11 = happyReduce 5# 3# happyReduction_11
happyReduction_11 (_ `HappyStk`
        (HappyAbsSyn12  happy_var_4) `HappyStk`
        _ `HappyStk`
        (HappyTerminal (TK _ (VARNAME happy_var_2))) `HappyStk`
        _ `HappyStk`
        happyRest)
         = HappyAbsSyn7
                 (";/ print...\n" ++ getArrayElementFromIndex happy_var_2 happy_var_4 ++ "\tLOAD\n" ++ "\tOUT\n"
        ) `HappyStk` happyRest

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_12 = happyReduce 5# 4# happyReduction_12
happyReduction_12 (_ `HappyStk`
        (HappyAbsSyn5  happy_var_4) `HappyStk`
        _ `HappyStk`
        (HappyAbsSyn12  happy_var_2) `HappyStk`
        (HappyTerminal happy_var_1) `HappyStk`
        happyRest)
         = HappyAbsSyn8
                 (let labelStartWhile = "labelStartWhile" ++ show(getTLine happy_var_1) ++ "Col" ++ show(getTCol happy_var_1) in
  let labelEndWhile = "labelEndWhile" ++ show(getTLine happy_var_1) ++ "Col" ++ show(getTCol happy_var_1) in
  ";/ While Loop\n" ++ labelStartWhile ++ "\tEQU\t*\n" ++ happy_var_2 ++ "\tBEZ\t" ++ labelEndWhile ++ "\n" ++ happy_var_4 ++ push labelStartWhile ++ "\tGOTO\n" ++ labelEndWhile ++ "\tEQU\t*\n"
        ) `HappyStk` happyRest

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_13 = happyReduce 9# 5# happyReduction_13
happyReduction_13 (_ `HappyStk`
        (HappyAbsSyn5  happy_var_8) `HappyStk`
        _ `HappyStk`
        (HappyTerminal happy_var_6) `HappyStk`
        _ `HappyStk`
        (HappyAbsSyn5  happy_var_4) `HappyStk`
        _ `HappyStk`
        (HappyAbsSyn12  happy_var_2) `HappyStk`
        (HappyTerminal happy_var_1) `HappyStk`
        happyRest)
         = HappyAbsSyn9
                 (let labelIf = "labelIf" ++ show(getTLine happy_var_1) ++ "Col" ++ show(getTCol happy_var_1) in
    let labelElse = "labelElse" ++ show(getTLine happy_var_6) ++ "Col" ++ show(getTCol happy_var_6) in
    ";/ If Then Else Condition\n" ++ happy_var_2 ++ "\tBEZ\t" ++ labelElse ++ "\n" ++ happy_var_4 ++ push labelIf ++ "\tGOTO\n" ++ labelElse ++ "\tEQU\t*\n" ++ happy_var_8 ++ labelIf ++ "\tEQU\t*\n"
        ) `HappyStk` happyRest

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_14 = happyReduce 5# 5# happyReduction_14
happyReduction_14 (_ `HappyStk`
        (HappyAbsSyn5  happy_var_4) `HappyStk`
        _ `HappyStk`
        (HappyAbsSyn12  happy_var_2) `HappyStk`
        (HappyTerminal happy_var_1) `HappyStk`
        happyRest)
         = HappyAbsSyn9
                 (let labelIf = "labelIf" ++ show(getTLine happy_var_1) ++ "Col" ++ show(getTCol happy_var_1) in
      ";/ If Then Condition\n" ++ happy_var_2 ++ "\tBEZ\t" ++ labelIf ++ "\n" ++ happy_var_4 ++ labelIf ++ "\tEQU\t*\n"
        ) `HappyStk` happyRest

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_15 = happySpecReduce_2  6# happyReduction_15
happyReduction_15 (HappyAbsSyn11  happy_var_2)
        _
         =  HappyAbsSyn10
                 (happy_var_2
        )
happyReduction_15 _ _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_16 = happySpecReduce_3  6# happyReduction_16
happyReduction_16 (HappyAbsSyn12  happy_var_3)
        _
        (HappyTerminal (TK _ (VARNAME happy_var_1)))
         =  HappyAbsSyn10
                 (affectVariableValue happy_var_1 happy_var_3
        )
happyReduction_16 _ _ _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_17 = happyReduce 4# 6# happyReduction_17
happyReduction_17 ((HappyAbsSyn12  happy_var_4) `HappyStk`
        _ `HappyStk`
        (HappyTerminal (TK _ (VARNAME happy_var_2))) `HappyStk`
        _ `HappyStk`
        happyRest)
         = HappyAbsSyn10
                 (declareVariable happy_var_2 ++ affectVariableValue happy_var_2 happy_var_4
        ) `HappyStk` happyRest

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_18 = happySpecReduce_3  6# happyReduction_18
happyReduction_18 (HappyTerminal (TK _ (INT happy_var_3)))
        (HappyTerminal (TK _ (VARNAME happy_var_2)))
        _
         =  HappyAbsSyn10
                 (happy_var_2 ++"\tDS\t" ++ (show happy_var_3) ++ "\n"
        )
happyReduction_18 _ _ _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_19 = happyReduce 6# 6# happyReduction_19
happyReduction_19 ((HappyAbsSyn12  happy_var_6) `HappyStk`
        _ `HappyStk`
        _ `HappyStk`
        (HappyAbsSyn12  happy_var_3) `HappyStk`
        _ `HappyStk`
        (HappyTerminal (TK _ (VARNAME happy_var_1))) `HappyStk`
        happyRest)
         = HappyAbsSyn10
                 (getArrayElementFromIndex happy_var_1 happy_var_3 ++ happy_var_6 ++ "\tSTORE\n"
        ) `HappyStk` happyRest

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_20 = happySpecReduce_1  7# happyReduction_20
happyReduction_20 (HappyTerminal (TK _ (VARNAME happy_var_1)))
         =  HappyAbsSyn11
                 (declareVariable happy_var_1
        )
happyReduction_20 _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_21 = happySpecReduce_3  7# happyReduction_21
happyReduction_21 (HappyAbsSyn11  happy_var_3)
        _
        (HappyTerminal (TK _ (VARNAME happy_var_1)))
         =  HappyAbsSyn11
                 (declareVariable happy_var_1 ++ happy_var_3
        )
happyReduction_21 _ _ _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_22 = happySpecReduce_1  8# happyReduction_22
happyReduction_22 (HappyAbsSyn13  happy_var_1)
         =  HappyAbsSyn12
                 (happy_var_1
        )
happyReduction_22 _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_23 = happySpecReduce_2  8# happyReduction_23
happyReduction_23 (HappyAbsSyn12  happy_var_2)
        _
         =  HappyAbsSyn12
                 (push "0" ++ happy_var_2 ++ substract
        )
happyReduction_23 _ _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_24 = happySpecReduce_3  8# happyReduction_24
happyReduction_24 (HappyAbsSyn12  happy_var_3)
        _
        (HappyAbsSyn12  happy_var_1)
         =  HappyAbsSyn12
                 (happy_var_1 ++ happy_var_3 ++ add
        )
happyReduction_24 _ _ _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_25 = happySpecReduce_3  8# happyReduction_25
happyReduction_25 (HappyAbsSyn12  happy_var_3)
        _
        (HappyAbsSyn12  happy_var_1)
         =  HappyAbsSyn12
                 (happy_var_1 ++ happy_var_3 ++ substract
        )
happyReduction_25 _ _ _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_26 = happySpecReduce_3  8# happyReduction_26
happyReduction_26 (HappyAbsSyn12  happy_var_3)
        _
        (HappyAbsSyn12  happy_var_1)
         =  HappyAbsSyn12
                 (happy_var_1 ++ happy_var_1 ++ happy_var_3 ++ divide ++ happy_var_3 ++ multiply ++ substract
        )
happyReduction_26 _ _ _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_27 = happySpecReduce_1  9# happyReduction_27
happyReduction_27 (HappyAbsSyn14  happy_var_1)
         =  HappyAbsSyn13
                 (happy_var_1
        )
happyReduction_27 _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_28 = happySpecReduce_3  9# happyReduction_28
happyReduction_28 (HappyAbsSyn14  happy_var_3)
        _
        (HappyAbsSyn13  happy_var_1)
         =  HappyAbsSyn13
                 (happy_var_1 ++ happy_var_3 ++ multiply
        )
happyReduction_28 _ _ _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_29 = happySpecReduce_3  9# happyReduction_29
happyReduction_29 (HappyAbsSyn14  happy_var_3)
        _
        (HappyAbsSyn13  happy_var_1)
         =  HappyAbsSyn13
                 (happy_var_1 ++ happy_var_3 ++ divide
        )
happyReduction_29 _ _ _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_30 = happySpecReduce_1  10# happyReduction_30
happyReduction_30 (HappyTerminal (TK _ (INT happy_var_1)))
         =  HappyAbsSyn14
                 (push (show happy_var_1)
        )
happyReduction_30 _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_31 = happySpecReduce_3  10# happyReduction_31
happyReduction_31 _
        (HappyAbsSyn12  happy_var_2)
        _
         =  HappyAbsSyn14
                 (happy_var_2
        )
happyReduction_31 _ _ _  = notHappyAtAll 

#if __GLASGOW_HASKELL__ >= 710
#endif
happyReduce_32 = happySpecReduce_1  10# happyReduction_32
happyReduction_32 (HappyTerminal (TK _ (VARNAME happy_var_1)))
         =  HappyAbsSyn14
                 (push happy_var_1 ++ "\tLOAD\n"
        )
happyReduction_32 _  = notHappyAtAll 

happyNewToken action sts stk [] =
        happyDoAction 28# notHappyAtAll action sts stk []

happyNewToken action sts stk (tk:tks) =
        let cont i = happyDoAction i tk action sts stk tks in
        case tk of {
        TK _ PRINT -> cont 1#;
        TK _ SEP -> cont 2#;
        TK _ (INT happy_dollar_dollar) -> cont 3#;
        TK _ PLUS -> cont 4#;
        TK _ SUB -> cont 5#;
        TK _ MUL -> cont 6#;
        TK _ DIV -> cont 7#;
        TK _ MOD -> cont 8#;
        TK _ LPAR -> cont 9#;
        TK _ RPAR -> cont 10#;
        TK _ COS -> cont 11#;
        TK _ SIN -> cont 12#;
        TK _ SQRT -> cont 13#;
        TK _ POWER -> cont 14#;
        TK _ VAR -> cont 15#;
        TK _ (VARNAME happy_dollar_dollar) -> cont 16#;
        TK _ ARRAY -> cont 17#;
        TK _ ASSIGN -> cont 18#;
        TK _ IN -> cont 19#;
        TK _ IF -> cont 20#;
        TK _ ELSE -> cont 21#;
        TK _ WHILE -> cont 22#;
        TK _ LEFTCURLYBRACKET -> cont 23#;
        TK _ RIGHTCURLYBRACKET -> cont 24#;
        TK _ LEFTSQUAREDBRACKET -> cont 25#;
        TK _ RIGHTSQUAREDBRACKET -> cont 26#;
        TK _ COMMA -> cont 27#;
        _ -> happyError' ((tk:tks), [])
        }

happyError_ explist 28# tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Prelude.Functor HappyIdentity where
    fmap f (HappyIdentity a) = HappyIdentity (f a)

instance Applicative HappyIdentity where
    pure  = HappyIdentity
    (<*>) = ap
instance Prelude.Monad HappyIdentity where
    return = pure
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (Prelude.>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (Prelude.return)
happyThen1 m k tks = (Prelude.>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (Prelude.return) a
happyError' :: () => ([(Token)], [Prelude.String]) -> HappyIdentity a
happyError' = HappyIdentity Prelude.. (\(tokens, _) -> parseError tokens)
parse tks = happyRunIdentity happySomeParser where
 happySomeParser = happyThen (happyParse 0# tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


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
-- $Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp $

#if !defined(__GLASGOW_HASKELL__)
#  error This code isn't being built with GHC.
#endif

-- Get WORDS_BIGENDIAN (if defined)
#include "MachDeps.h"

-- Do not remove this comment. Required to fix CPP parsing when using GCC and a clang-compiled alex.
#if __GLASGOW_HASKELL__ > 706
#  define LT(n,m) ((Happy_GHC_Exts.tagToEnum# (n Happy_GHC_Exts.<# m)) :: Prelude.Bool)
#  define GTE(n,m) ((Happy_GHC_Exts.tagToEnum# (n Happy_GHC_Exts.>=# m)) :: Prelude.Bool)
#  define EQ(n,m) ((Happy_GHC_Exts.tagToEnum# (n Happy_GHC_Exts.==# m)) :: Prelude.Bool)
#else
#  define LT(n,m) (n Happy_GHC_Exts.<# m)
#  define GTE(n,m) (n Happy_GHC_Exts.>=# m)
#  define EQ(n,m) (n Happy_GHC_Exts.==# m)
#endif
#define PLUS(n,m) (n Happy_GHC_Exts.+# m)
#define MINUS(n,m) (n Happy_GHC_Exts.-# m)
#define TIMES(n,m) (n Happy_GHC_Exts.*# m)
#define NEGATE(n) (Happy_GHC_Exts.negateInt# (n))

type Happy_Int = Happy_GHC_Exts.Int#
data Happy_IntList = HappyCons Happy_Int Happy_IntList

#define ERROR_TOK 0#

#if defined(HAPPY_COERCE)
#  define GET_ERROR_TOKEN(x)  (case Happy_GHC_Exts.unsafeCoerce# x of { (Happy_GHC_Exts.I# i) -> i })
#  define MK_ERROR_TOKEN(i)   (Happy_GHC_Exts.unsafeCoerce# (Happy_GHC_Exts.I# i))
#  define MK_TOKEN(x)         (happyInTok (x))
#else
#  define GET_ERROR_TOKEN(x)  (case x of { HappyErrorToken (Happy_GHC_Exts.I# i) -> i })
#  define MK_ERROR_TOKEN(i)   (HappyErrorToken (Happy_GHC_Exts.I# i))
#  define MK_TOKEN(x)         (HappyTerminal (x))
#endif

#if defined(HAPPY_DEBUG)
#  define DEBUG_TRACE(s)    (happyTrace (s)) $
happyTrace string expr = Happy_System_IO_Unsafe.unsafePerformIO $ do
    Happy_System_IO.hPutStr Happy_System_IO.stderr string
    return expr
#else
#  define DEBUG_TRACE(s)    {- nothing -}
#endif

infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is ERROR_TOK, it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept ERROR_TOK tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) =
        (happyTcHack j (happyTcHack st)) (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action

happyDoAction i tk st =
  DEBUG_TRACE("state: " ++ show (Happy_GHC_Exts.I# st) ++
              ",\ttoken: " ++ show (Happy_GHC_Exts.I# i) ++
              ",\taction: ")
  case happyDecodeAction (happyNextAction i st) of
    HappyFail             -> DEBUG_TRACE("failing.\n")
                             happyFail (happyExpListPerState (Happy_GHC_Exts.I# st)) i tk st
    HappyAccept           -> DEBUG_TRACE("accept.\n")
                             happyAccept i tk st
    HappyReduce rule      -> DEBUG_TRACE("reduce (rule " ++ show (Happy_GHC_Exts.I# rule) ++ ")")
                             (happyReduceArr Happy_Data_Array.! (Happy_GHC_Exts.I# rule)) i tk st
    HappyShift  new_state -> DEBUG_TRACE("shift, enter state " ++ show (Happy_GHC_Exts.I# new_state) ++ "\n")
                             happyShift new_state i tk st

{-# INLINE happyNextAction #-}
happyNextAction i st = case happyIndexActionTable i st of
  Just (Happy_GHC_Exts.I# act) -> act
  Nothing                      -> happyIndexOffAddr happyDefActions st

{-# INLINE happyIndexActionTable #-}
happyIndexActionTable i st
  | GTE(off, 0#), EQ(happyIndexOffAddr happyCheck off, i)
  = Prelude.Just (Happy_GHC_Exts.I# (happyIndexOffAddr happyTable off))
  | otherwise
  = Prelude.Nothing
  where
    off = PLUS(happyIndexOffAddr happyActOffsets st, i)

data HappyAction
  = HappyFail
  | HappyAccept
  | HappyReduce Happy_Int -- rule number
  | HappyShift Happy_Int  -- new state

{-# INLINE happyDecodeAction #-}
happyDecodeAction :: Happy_Int -> HappyAction
happyDecodeAction  0#                        = HappyFail
happyDecodeAction -1#                        = HappyAccept
happyDecodeAction action | LT(action, 0#)    = HappyReduce NEGATE(PLUS(action, 1#))
                         | otherwise         = HappyShift MINUS(action, 1#)

{-# INLINE happyIndexGotoTable #-}
happyIndexGotoTable nt st = happyIndexOffAddr happyTable off
  where
    off = PLUS(happyIndexOffAddr happyGotoOffsets st, nt)

{-# INLINE happyIndexOffAddr #-}
happyIndexOffAddr :: HappyAddr -> Happy_Int -> Happy_Int
happyIndexOffAddr (HappyA# arr) off =
#if __GLASGOW_HASKELL__ >= 901
  Happy_GHC_Exts.int32ToInt# -- qualified import because it doesn't exist on older GHC's
#endif
#ifdef WORDS_BIGENDIAN
  -- The CI of `alex` tests this code path
  (Happy_GHC_Exts.word32ToInt32# (Happy_GHC_Exts.wordToWord32# (Happy_GHC_Exts.byteSwap32# (Happy_GHC_Exts.word32ToWord# (Happy_GHC_Exts.int32ToWord32#
#endif
  (Happy_GHC_Exts.indexInt32OffAddr# arr off)
#ifdef WORDS_BIGENDIAN
  )))))
#endif

{-# INLINE happyLt #-}
happyLt x y = LT(x,y)

readArrayBit arr bit =
    Bits.testBit (Happy_GHC_Exts.I# (happyIndexOffAddr arr ((unbox_int bit) `Happy_GHC_Exts.iShiftRA#` 5#))) (bit `Prelude.mod` 32)
  where unbox_int (Happy_GHC_Exts.I# x) = x

data HappyAddr = HappyA# Happy_GHC_Exts.Addr#

-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state ERROR_TOK tk st sts stk@(x `HappyStk` _) =
     let i = GET_ERROR_TOKEN(x) in
-- trace "shifting the error token" $
     happyDoAction i tk new_state (HappyCons st sts) stk

happyShift new_state i tk st sts stk =
     happyNewToken new_state (HappyCons st sts) (MK_TOKEN(tk) `HappyStk` stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn ERROR_TOK tk st sts stk
     = happyFail [] ERROR_TOK tk st sts stk
happySpecReduce_0 nt fn j tk st sts stk
     = happyGoto nt j tk st (HappyCons st sts) (fn `HappyStk` stk)

happySpecReduce_1 i fn ERROR_TOK tk st sts stk
     = happyFail [] ERROR_TOK tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(HappyCons st _) (v1 `HappyStk` stk')
     = let r = fn v1 in
       happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn ERROR_TOK tk st sts stk
     = happyFail [] ERROR_TOK tk st sts stk
happySpecReduce_2 nt fn j tk _
  (HappyCons _ sts@(HappyCons st _))
  (v1 `HappyStk` v2 `HappyStk` stk')
     = let r = fn v1 v2 in
       happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn ERROR_TOK tk st sts stk
     = happyFail [] ERROR_TOK tk st sts stk
happySpecReduce_3 nt fn j tk _
  (HappyCons _ (HappyCons _ sts@(HappyCons st _)))
  (v1 `HappyStk` v2 `HappyStk` v3 `HappyStk` stk')
     = let r = fn v1 v2 v3 in
       happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn ERROR_TOK tk st sts stk
     = happyFail [] ERROR_TOK tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop MINUS(k,(1# :: Happy_Int)) sts of
         sts1@(HappyCons st1 _) ->
                let r = fn stk in -- it doesn't hurt to always seq here...
                happyDoSeq r (happyGoto nt j tk st1 sts1 r)

happyMonadReduce k nt fn ERROR_TOK tk st sts stk
     = happyFail [] ERROR_TOK tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k (HappyCons st sts) of
        sts1@(HappyCons st1 _) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk)
                     (\r -> happyGoto nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn ERROR_TOK tk st sts stk
     = happyFail [] ERROR_TOK tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k (HappyCons st sts) of
        sts1@(HappyCons st1 _) ->
          let drop_stk = happyDropStk k stk
              off = happyAdjustOffset (happyIndexOffAddr happyGotoOffsets st1)
              off_i = PLUS(off, nt)
              new_state = happyIndexOffAddr happyTable off_i
          in
            happyThen1 (fn stk tk)
                       (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop 0# l               = l
happyDrop n  (HappyCons _ t) = happyDrop MINUS(n,(1# :: Happy_Int)) t

happyDropStk 0# l                 = l
happyDropStk n  (x `HappyStk` xs) = happyDropStk MINUS(n,(1#::Happy_Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction

happyGoto nt j tk st =
   DEBUG_TRACE(", goto state " ++ show (Happy_GHC_Exts.I# new_state) ++ "\n")
   happyDoAction j tk new_state
  where new_state = happyIndexGotoTable nt st

-----------------------------------------------------------------------------
-- Error recovery (ERROR_TOK is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist ERROR_TOK tk old_st _ stk@(x `HappyStk` _) =
     let i = GET_ERROR_TOKEN(x) in
--      trace "failing" $
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  ERROR_TOK tk old_st (HappyCons action sts)
                               (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        happyDoAction ERROR_TOK tk action sts (saved_tok`HappyStk`stk)
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk action sts stk =
-- trace "entering error recovery" $
        happyDoAction ERROR_TOK tk action sts (MK_ERROR_TOKEN(i) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = Prelude.error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions

happyTcHack :: Happy_Int -> a -> a
happyTcHack x y = y
{-# INLINE happyTcHack #-}

-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `Prelude.seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.

{-# NOINLINE happyDoAction #-}
{-# NOINLINE happyTable #-}
{-# NOINLINE happyCheck #-}
{-# NOINLINE happyActOffsets #-}
{-# NOINLINE happyGotoOffsets #-}
{-# NOINLINE happyDefActions #-}

{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
