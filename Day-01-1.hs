-- AdventOfCode 2023 Day 1, Puzzle 1
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
  

tidy :: String -> [Int]
tidy [] = []
tidy (x:xs)
  | x == '1'  = (1:(tidy xs))
  | x == '2'  = (2:(tidy xs))
  | x == '3'  = (3:(tidy xs))
  | x == '4'  = (4:(tidy xs))
  | x == '5'  = (5:(tidy xs))
  | x == '6'  = (6:(tidy xs))
  | x == '7'  = (7:(tidy xs))
  | x == '8'  = (8:(tidy xs))
  | x == '9'  = (9:(tidy xs))
  | x == '0'  = (0:(tidy xs))
  | otherwise = (tidy xs)

main :: IO()
main = do
  [fileInput] <- getArgs
  fileContents <- readFile fileInput
  let answer = foldr1 (+) (map calibrate (map tidy (lines fileContents)))
         in putStrLn (show answer)
