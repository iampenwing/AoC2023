-- AdventOfCode 2023 Day 4, Puzzle 2
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

buildCards :: [[[Int]]] -> [(Int, Int, [Int], [Int])]
buildCards [] = []
buildCards (x:xs) = ((head (head x)), 1, (head (tail x)), (head (tail (tail x)))):(buildCards xs)

scoreGame :: [Int] -> [Int] -> Int
scoreGame winners have = (length (filter (\x -> (elem x winners)) have))

playGame :: [(Int, Int, [Int], [Int])] -> Int
playGame [] = 0
playGame ((gameID, n, winners, have):xs) = n + (playGame (updateCards xs n (scoreGame winners have)))

updateCards :: [(Int, Int, [Int], [Int])] -> Int -> Int -> [(Int, Int, [Int], [Int])]
updateCards [] _ _ = []
updateCards ((gameID, count, winners, have):xs) n m
  | m == 0    = ((gameID, count, winners, have):xs)
  | otherwise = ((gameID, (count + n), winners, have):(updateCards xs n (m - 1)))



main :: IO()
main = do
  [fileInput] <- getArgs
  fileContents <- readFile fileInput
  let answer = playGame (buildCards (map (map getInts) (map (splitOneOf ":|") (lines fileContents))))
         in putStrLn (show answer)
