-- AdventOfCode 2023 Day 3, Puzzle 2
-- Gear Ratios
-- https://adventofcode.com/2023/day/3


-- Alex Lambert (penwing)
-- aoc@penwing.me.uk

-- import File
import Data.String
import Data.List.Split
import System.Environment
import AoCLib.AoCLib as AoC

findNumbersAndSymbols :: [String] -> [([(Char, (Int, Int))], Int)]
findNumbersAndSymbols plan = findNumbersAndSymbols_ plan (0, 0) ((length (head plan)), (length plan))

findNumbersAndSymbols_ :: [String] -> (Int, Int) -> (Int, Int) -> [([(Char, (Int, Int))], Int)]
findNumbersAndSymbols_ [] _ _ = []
findNumbersAndSymbols_ plan (cx, cy) (mx, my)
  | cy >= my = []
  | cx >= mx = findNumbersAndSymbols_ plan (0, (cy+1)) (mx, my)
  | sym == '1' || sym == '2' || sym == '3' || sym == '4' || sym == '5' || sym == '6' || sym == '7' || sym =='8' || sym == '9' || sym == '0' =
      let (num, len) = (getNumber 0 0 (drop cx (plan!!cy)))
      in (((getSymbols plan (cx, cy) (mx, my) len), num):(findNumbersAndSymbols_ plan ((cx+len), cy) (mx,my)))
  | otherwise = findNumbersAndSymbols_ plan ((cx+1), cy) (mx, my) 
  where sym = (plan!!cy)!!cx

getNumber :: Int -> Int -> String -> (Int, Int)
getNumber n l [] = (n, l)
getNumber n l (y:ys)
  | y == '1' = getNumber ((n*10)+1) (l+1) ys
  | y == '2' = getNumber ((n*10)+2) (l+1) ys
  | y == '3' = getNumber ((n*10)+3) (l+1) ys
  | y == '4' = getNumber ((n*10)+4) (l+1) ys
  | y == '5' = getNumber ((n*10)+5) (l+1) ys
  | y == '6' = getNumber ((n*10)+6) (l+1) ys
  | y == '7' = getNumber ((n*10)+7) (l+1) ys
  | y == '8' = getNumber ((n*10)+8) (l+1) ys
  | y == '9' = getNumber ((n*10)+9) (l+1) ys
  | y == '0' = getNumber ((n*10)+0) (l+1) ys
  | otherwise = (n, l)

--             plan         start         size       length   symbols
getSymbols :: [String] -> (Int, Int) -> (Int, Int) -> Int -> [(Char, (Int, Int))]
getSymbols plan (cx, cy) (mx, my) l
  = findGearSym ((getTopSymbols plan (cx, cy) (mx, my) l) ++
    (getLeftSymbols plan (cx, cy) (mx, my) l) ++
    (getRightSymbols plan (cx, cy) (mx, my) l) ++
    (getBottomSymbols plan (cx, cy) (mx, my) l))

getTopSymbols :: [String] -> (Int, Int) -> (Int, Int) -> Int -> [(Char, (Int, Int))]
getTopSymbols plan (cx, cy) (mx, my) l = if (cy == 0)
                                            then []
                                            else makeSymbols ((max (cx-1) 0), (cy-1)) (take (l + 2) (drop (max (cx-1) 0) (plan!!(cy-1))))



getLeftSymbols :: [String] -> (Int, Int) -> (Int, Int) -> Int -> [(Char, (Int, Int))]
getLeftSymbols plan (cx, cy) (mx, my) l = if (cx == 0)
                                          then []
                                          else [(((plan!!cy)!!(cx-1)), ((cx-1), cy))]


getRightSymbols :: [String] -> (Int, Int) -> (Int, Int) -> Int -> [(Char, (Int, Int))]
getRightSymbols plan (cx, cy) (mx, my) l = if (cx+l) >= mx
                                           then []
                                           else [(((plan!!cy)!!(cx+l)), ((cx+l), cy))]
  
getBottomSymbols :: [String] -> (Int, Int) -> (Int, Int) -> Int -> [(Char, (Int, Int))]
getBottomSymbols plan (cx, cy) (mx, my) l = if (cy == (my-1))
                                            then []
                                            else makeSymbols ((max (cx-1) 0), (cy+1)) (take (l + 2) (drop (max (cx-1) 0) (plan!!(cy+1))))

makeSymbols :: (Int, Int) -> String -> [(Char, (Int, Int))]
makeSymbols _ [] = []
makeSymbols (x, y) (z:zs)
  | z == '.'  = makeSymbols ((x+1), y) zs
  | otherwise = (z, (x, y)):(makeSymbols ((x+1), y) zs)

findGearSym :: [(Char, (Int, Int))] -> [(Char, (Int, Int))]
findGearSym [] = []
findGearSym ((s, loc):xs)
  | s == '*'  = (s, loc):(findGearSym xs)
  | otherwise = findGearSym xs

refactorGears :: [([(Char, (Int, Int))], Int)] -> [((Int, Int), [Int])] -> [((Int, Int), [Int])]
refactorGears [] acc = acc
refactorGears (x:xs) acc = refactorGears xs (refactorGears_ x acc)
  
refactorGears_ :: ([(Char, (Int, Int))], Int) -> [((Int, Int), [Int])] -> [((Int, Int), [Int])]
refactorGears_ ([], _) acc = acc
refactorGears_ ((x:xs), g) acc = refactorGears_ (xs, g) (insertIntoGearsList (snd x) g acc)

insertIntoGearsList :: (Int, Int) -> Int -> [((Int, Int), [Int])] -> [((Int, Int), [Int])]
insertIntoGearsList loc g [] = [(loc, [g])]
insertIntoGearsList loc g ((l, gs):acc)
  | loc == l  = (loc, (g:gs)):acc
  | otherwise = (l, gs):(insertIntoGearsList loc g acc)

findGearRatios :: [((Int, Int), [Int])] -> [Int]
findGearRatios [] = []
findGearRatios ((l, gs):xs)
  | (length gs) == 2 = ((head gs) * (head (tail gs))):(findGearRatios xs)
  | otherwise        = findGearRatios xs
  
getPartNumbers :: [([(Char, (Int, Int))], Int)] -> [Int]
getPartNumbers [] = []
getPartNumbers (([], _):xs) = getPartNumbers xs
getPartNumbers ((s, n):xs) = n:(getPartNumbers xs)

main :: IO()
main = do
  [fileInput] <- getArgs
  fileContents <- readFile fileInput
  let answer = foldr1 (+) (findGearRatios (refactorGears (findNumbersAndSymbols (lines fileContents)) []))
         in putStrLn (show answer)
