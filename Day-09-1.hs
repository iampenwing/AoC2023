-- AdventOfCode 2023 Day 9, Puzzle 1
-- Mirage Maintenance
-- https://adventofcode.com/2023/day/9

-- Alex Lambert (penwing)
-- aoc@penwing.me.uk

-- import File
import Data.String
import System.Environment
import AoCLib.AoCLib as AoC

generateDifferences :: [Integer] -> [[Integer]]
generateDifferences seq
  | foldl1 (&&) (map ((==) 0) seq) = []
  | otherwise                      = seq:(generateDifferences newSeq)
    where newSeq = (zipWith (-) (tail seq) seq)

nextInSeq :: [[Integer]] -> Integer
nextInSeq []         = 0
nextInSeq (seq:seqs) = (lastIn seq) + (nextInSeq seqs)

lastIn :: [a] -> a
lastIn (x:[]) = x
lastIn (x:xs) = lastIn xs

main :: IO()
main = do
  [fileInput] <- getArgs
  fileContents <- readFile fileInput
  let answer = foldr1 (+) (map nextInSeq (map generateDifferences (map (reverse . AoC.getInts) (lines fileContents))))
         in putStrLn (show answer)
