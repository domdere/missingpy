{- arch-tag: Test utilities
Copyright (C) 2004 John Goerzen <jgoerzen@complete.org>

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-}

module Testutil (   assertRaises
                ,   mapassertEqual
                ,   testBigInt
                ,   testMedInt
                ,   testBigDouble
                ) where

import Test.HUnit
import Control.Monad (unless)
import qualified Control.Exception
import Foreign.C.Types (CDouble)

testBigInt :: Integer
testBigInt = (2 :: Integer) ^ (348 :: Integer)

-- Test that a function wont overflow
testMedInt :: Integer
testMedInt = (2 :: Integer) ^ (32 :: Integer)

testBigDouble :: CDouble
testBigDouble= 2.0 ^^ (348 :: Integer)

assertRaises :: (Show a, Control.Exception.Exception b, Eq b) => String -> b -> IO a -> IO ()
assertRaises msg selector action =
    let thetest e = unless (e == selector) $
                    assertFailure $ msg ++ "\nReceived unexpected exception: "
                        ++ show e ++ "\ninstead of exception: " ++ show selector
        in do
           r <- Control.Exception.try action
           case r of
                  Left e -> thetest e
                  Right _ -> assertFailure $ msg ++ "\nReceived no exception, but was expecting exception: " ++ show selector

mapassertEqual :: (Show b, Eq b) => String -> (a -> b) -> [(a, b)] -> [Test]
mapassertEqual _ _ [] = []
mapassertEqual descrip func ((inp,result):xs) =
    (TestCase $ assertEqual descrip result (func inp)) : mapassertEqual descrip func xs
