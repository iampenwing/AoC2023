-- AdventOfCode 2023 Day 10, Puzzle 1
-- Pipe Maze
-- https://adventofcode.com/2023/day/10

-- Alex Lambert (penwing)
-- aoc@penwing.me.uk

-- import File
import Data.String
import System.Environment
import AoCLib.AoCLib as AoC

data Direction = North | East | South | West deriving (Show, Eq)

findStart :: [String] -> ((Int, Int), Direction, Direction)
findStart grid = findStart_ grid 0 0 lC lR
  where lR = (length (head grid)) - 1
        lC = (length grid) - 1

findStart_ :: [String] -> Int -> Int -> Int -> Int -> ((Int, Int), Direction, Direction)
findStart_ grid col row cols rows
  | curr == 'S' = findAdjacentPipes grid col row cols rows
  | col == cols = findStart_ grid 0 (row + 1) cols rows
  | otherwise   = findStart_ grid (col + 1) row cols rows
  where curr = ((grid!!row)!!col)

findAdjacentPipes :: [String] -> Int -> Int -> Int -> Int -> ((Int, Int), Direction, Direction)
findAdjacentPipes grid col row cols rows
  | col == 0 && row == 0       = ((col, row), East, South)
  | col == cols && row == rows = ((col, row), North, West)
  | col == 0 && row == rows    = ((col, row), East, North)
  | col == cols && row == 0    = ((col, row), South, West)
  | otherwise                  = findAdjacentPipes_ grid col row cols rows

findAdjacentPipes_ :: [String] -> Int -> Int -> Int -> Int -> ((Int, Int), Direction, Direction)
findAdjacentPipes_ grid col row cols rows
  | (n == '|' || n == '7' || n == 'F') && (e == '-' || e == 'J' || e == '7') = ((col, row), North, East)
  | (n == '|' || n == '7' || n == 'F') && (s == '|' || s == 'J' || s == 'L') = ((col, row), North, South)
  | (n == '|' || n == '7' || n == 'F') && (w == '-' || w == 'F' || w == 'L') = ((col, row), North, West)
  | (e == '-' || e == 'J' || e == '7') && (s == '|' || s == 'J' || s == 'L') = ((col, row), East, South)
  | (e == '-' || e == 'J' || e == '7') && (w == '-' || w == 'F' || w == 'L') = ((col, row), East, West)
  | (s == '|' || s == 'J' || s == 'L') && (w == '-' || w == 'F' || w == 'L') = ((col, row), South, West)
    where n = ((grid!!(row-1))!!col)
          e = ((grid!!row)!!(col+1))
          s = ((grid!!(row+1))!!col)
          w = ((grid!!row)!!(col-1))

followPipes :: [String] -> ((Int, Int), Direction, Direction) -> ((Int, Int), Int)
followPipes grid ((row, col), dir1, dir2) = followPipes_ grid ((row, col), dir1) ((row, col), dir2) 0

followPipes_ :: [String] -> ((Int, Int), Direction) -> ((Int, Int), Direction) -> Int -> ((Int, Int), Int)
followPipes_ grid ((col1, row1), dir1) ((col2, row2), dir2) count
  | col1 == col2 && row1 == row2 && ((grid!!row1)!!col1) /= 'S' = ((col1, row1), count)
  | otherwise                                                 = followPipes_ grid (newPlace grid ((col1, row1), dir1)) (newPlace grid ((col2, row2), dir2)) (count + 1)

newPlace :: [String] -> ((Int, Int), Direction) -> ((Int, Int), Direction)
newPlace grid ((col, row), dir)
  | dir == North = ((col, (row - 1)), (getDirection ((grid!!(row-1))!!col) dir))
  | dir == East = (((col + 1), row), (getDirection ((grid!!row)!!(col+1)) dir))
  | dir == South = ((col, (row + 1)), (getDirection ((grid!!(row+1))!!col) dir))
  | dir == West = (((col - 1), row), (getDirection ((grid!!row)!!(col-1)) dir))

getDirection :: Char -> Direction -> Direction
getDirection c d
  | c == '|' && d == North = North
  | c == '|' && d == South = South
  | c == '-' && d == East = East
  | c == '-' && d == West = West
  | c == 'L' && d == South = East
  | c == 'L' && d == West = North
  | c == 'J' && d == South = West
  | c == 'J' && d == East = North
  | c == '7' && d == North = West
  | c == '7' && d == East = South
  | c == 'F' && d == West = South
  | c == 'F' && d == North = East

main :: IO()
main = do
  [fileInput] <- getArgs
  fileContents <- readFile fileInput
  let grid = (lines fileContents)
      answer = followPipes grid (findStart grid)
         in putStrLn (show answer)
