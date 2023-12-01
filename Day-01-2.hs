-- AdventOfCode 2023 Day 1, Puzzle 2
-- Trebuchet?
-- https://adventofcode.com/2023/day/1
-- Tidying up calibration information that an over-enthuisiastic elf has
-- prettified beyond easy usefulness

-- Alex Lambert (penwing)
-- aoc@penwing.me.uk

-- import File
import Data.String
import System.Environment
import AoCLib.AoCLib as AoC

calibrate :: [Int] -> Int
calibrate (x:ys) = (10 * x) + (AoC.getLast (x:ys))

-- tidy now replaced with AoC.getDigits to reflect new understanding of digits

main :: IO()
main = do
  [fileInput] <- getArgs
  fileContents <- readFile fileInput
  let answer = foldr1 (+) (map (calibrate . AoC.getDigits) (lines fileContents))
         in putStrLn (show answer)
