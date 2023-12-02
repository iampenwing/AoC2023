-- AdventOfCode 2023 Day 2, Puzzle 1
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

filterValidGames :: [(Int, [(Int, Int, Int)])] -> (Int, Int, Int) -> [Int]
filterValidGames [] _ = []
filterValidGames (game:games) gameMax
  | isValidGame game gameMax = ((fst game):(filterValidGames games gameMax))
  | otherwise                = filterValidGames games gameMax

isValidGame :: (Int, [(Int, Int, Int)]) -> (Int, Int, Int) -> Bool
isValidGame (_, runs) gameMax = foldr1 (&&) (map (\x -> isValidRun x gameMax) runs)

isValidRun :: (Int, Int, Int) -> (Int, Int, Int) -> Bool
isValidRun (r, g, b) (rm, gm, bm) 
  | (r <= rm) && (g <= gm) && (b <= bm) = True
  | otherwise = False

        
main :: IO()
main = do
  [fileInput] <- getArgs
  fileContents <- readFile fileInput
  let answer = foldr1 (+) (filterValidGames (map readGame (lines fileContents)) (12, 13, 14))
         in putStrLn (show answer)
