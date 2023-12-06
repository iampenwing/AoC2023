-- AdventOfCode 2023 Day 6, Puzzle 1
-- Wait for it!
-- https://adventofcode.com/2023/day/6

-- Alex Lambert (penwing)
-- aoc@penwing.me.uk

-- import File
import Data.String
import System.Environment
import AoCLib.AoCLib as AoC

getRanges :: [(Float, Float)] -> [Int]
getRanges [] = []
getRanges (x:xs) = (getRange x):(getRanges xs)

getRange :: (Float, Float) -> Int
getRange (t, d) = (floor high) - (ceiling low) + mod
  where r    = sqrt ((t ^ 2) - (4 * d))
        low  = ((-t) + r) / (-2.0)
        high = ((-t) - r) / (-2.0)
        mod  = 1 + (if (fromIntegral (ceiling low)) == low then (-1) else 0) + (if (fromIntegral (floor high)) == high then (-1) else 0) 
                      

main :: IO()
main = do
  [fileInput] <- getArgs
  fileContents <- readFile fileInput
  let input = map (map fromIntegral) (map AoC.getInts (lines fileContents))
      races = reverse (zip (head input) (head (tail input)))
      answer = foldr1 (*) (getRanges races)
         in putStrLn (show answer)
 
