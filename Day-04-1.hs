-- AdventOfCode 2023 Day 4, Puzzle 1
-- Scratchcards
-- https://adventofcode.com/2023/day/4
-- Finding winning scratchcards

-- Alex Lambert (penwing)
-- aoc@penwing.me.uk

-- import File
import Data.String
import Data.List.Split
import System.Environment
import AoCLib.AoCLib as AoC

scoreGame :: [[Int]] -> (Int, Int)
scoreGame (gameID:(winners:(have:_)))
  | l < 0     = ((head gameID), 0)
  | otherwise = ((head gameID), (2 ^ l))
  where l = (length (filter (\x -> (elem x winners)) have)) - 1


addGames :: [(Int, Int)] -> Int
addGames [] = 0
addGames ((_,x):xs) = x + (addGames xs)

main :: IO()
main = do
  [fileInput] <- getArgs
  fileContents <- readFile fileInput
  let answer = addGames (map scoreGame (map (map getInts) (map (splitOneOf ":|") (lines fileContents))))
         in putStrLn (show answer)
