-- AdventOfCode 2023 Day 2, Puzzle 2
-- Cube Conumdrum
-- https://adventofcode.com/2023/day/2


-- Alex Lambert (penwing)
-- aoc@penwing.me.uk

-- import File
import Data.String
import Data.List.Split
import System.Environment
import AoCLib.AoCLib as AoC

splitData :: String -> (String, [String])
splitData x = ((head splits), (tail splits))
  where splits = splitOneOf ":;" x

getGameID :: String -> Int
getGameID (_:(_:(_:(_:(_:id))))) = read id :: Int

getRun :: String -> (Int, Int, Int)
getRun x = interpretCubes (map tail cubes) (0, 0, 0)
  where cubes = splitOn "," x

interpretCubes :: [String] -> (Int, Int, Int) -> (Int, Int, Int)
interpretCubes [] acc = acc
interpretCubes (x:xs) (red, green, blue)
  | colour == 1 = interpretCubes xs ((red + count), green, blue)
  | colour == 2 = interpretCubes xs (red, (green + count), blue)
  | colour == 3 = interpretCubes xs (red, green, (blue+count))
  where (colour, count) = readCubes (splitOn " " x)

readCubes :: [String] -> (Int, Int)
readCubes (count:(colour:_))
  | (head colour) == 'r' = (1, (read count :: Int))
  | (head colour) == 'g' = (2, (read count :: Int))
  | (head colour) == 'b' = (3, (read count :: Int))
  | otherwise = (0, 0)

readGame :: String -> (Int, [(Int, Int, Int)])
readGame x = ((getGameID gameID), (map getRun runs))
  where (gameID, runs) = splitData x

minGame :: [(Int, Int, Int)] -> (Int, Int, Int) -> (Int, Int, Int)
minGame [] acc = acc
minGame ((r, g, b):xs) (rm, gm, bm) = minGame xs ((max r rm), (max g gm), (max b bm))

powerGame :: (Int, Int, Int) -> Int
powerGame (r, g, b) = (r * g * b)

main :: IO()
main = do
  [fileInput] <- getArgs
  fileContents <- readFile fileInput
  let answer = foldr1 (+) (map (powerGame . (\x -> minGame x (0, 0, 0)) . snd. readGame) (lines fileContents))
         in putStrLn (show answer)
