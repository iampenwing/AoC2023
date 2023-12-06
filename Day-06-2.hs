-- AdventOfCode 2023 Day 6, Puzzle 1
-- Wait for it!
-- https://adventofcode.com/2023/day/6

-- Alex Lambert (penwing)
-- aoc@penwing.me.uk

-- import File
import Data.String
import System.Environment
import AoCLib.AoCLib as AoC

getRanges :: [(Double, Double)] -> [Integer]
getRanges [] = []
getRanges (x:xs) = (getRange x):(getRanges xs)

getRange :: (Double, Double) -> Integer
getRange (t, d) = (floor high) - (ceiling low) + mod
  where r    = sqrt ((t ^ 2) - (4 * d))
        low  = ((-t) + r) / (-2.0)
        high = ((-t) - r) / (-2.0)
        mod  = 1 + (if (fromIntegral (ceiling low)) == low then (-1) else 0) + (if (fromIntegral (floor high)) == high then (-1) else 0) 

getInts :: String -> [Integer]
getInts [] = []
getInts (x:xs)
  | x == '1' = getInts_inNumber xs 1 []
  | x == '2' = getInts_inNumber xs 2 []
  | x == '3' = getInts_inNumber xs 3 []
  | x == '4' = getInts_inNumber xs 4 []
  | x == '5' = getInts_inNumber xs 5 []
  | x == '6' = getInts_inNumber xs 6 []
  | x == '7' = getInts_inNumber xs 7 []
  | x == '8' = getInts_inNumber xs 8 []
  | x == '9' = getInts_inNumber xs 9 []
  | x == '0' = getInts_inNumber xs 0 []
  | otherwise = getInts_rubbish xs []

getInts_inNumber :: String -> Integer -> [Integer] -> [Integer]
getInts_inNumber [] n acc = (n:acc)
getInts_inNumber (x:xs) n acc
  | x == '1' = getInts_inNumber xs ((n * 10) + 1) acc
  | x == '2' = getInts_inNumber xs ((n * 10) + 2) acc
  | x == '3' = getInts_inNumber xs ((n * 10) + 3) acc
  | x == '4' = getInts_inNumber xs ((n * 10) + 4) acc
  | x == '5' = getInts_inNumber xs ((n * 10) + 5) acc
  | x == '6' = getInts_inNumber xs ((n * 10) + 6) acc
  | x == '7' = getInts_inNumber xs ((n * 10) + 7) acc
  | x == '8' = getInts_inNumber xs ((n * 10) + 8) acc
  | x == '9' = getInts_inNumber xs ((n * 10) + 9) acc
  | x == '0' = getInts_inNumber xs ((n * 10) + 0) acc
  | x == ' ' = getInts_inNumber xs n acc
  | otherwise = getInts_rubbish xs (n:acc)

getInts_rubbish :: String -> [Integer] -> [Integer]
getInts_rubbish [] acc = acc
getInts_rubbish (x:xs) acc
  | x == '1' = getInts_inNumber xs 1 acc
  | x == '2' = getInts_inNumber xs 2 acc
  | x == '3' = getInts_inNumber xs 3 acc
  | x == '4' = getInts_inNumber xs 4 acc
  | x == '5' = getInts_inNumber xs 5 acc
  | x == '6' = getInts_inNumber xs 6 acc
  | x == '7' = getInts_inNumber xs 7 acc
  | x == '8' = getInts_inNumber xs 8 acc
  | x == '9' = getInts_inNumber xs 9 acc
  | x == '0' = getInts_inNumber xs 0 acc
  | otherwise = getInts_rubbish xs acc


main :: IO()
main = do
  [fileInput] <- getArgs
  fileContents <- readFile fileInput
  let input = map (map fromIntegral) (map Main.getInts (lines fileContents))
      races = reverse (zip (head input) (head (tail input)))
      answer = foldr1 (*) (getRanges races)
         in putStrLn (show answer)
 
