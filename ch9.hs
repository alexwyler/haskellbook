module Ch9 where

eftInt :: Int -> Int -> [Int]
eftInt start end
 | start > end = []
 | otherwise   = start : eftInt (start + 1) end


myWords :: [Char] -> [[Char]]

myWords string
 | chunk == [] = []
 | otherwise   = chunk : (myWords remainder)
 where
    chunk = takeWhile (not . (== ' ')) string
    remainderWithSpace = dropWhile (not . (== ' ')) string
    remainder = if remainderWithSpace == [] then remainderWithSpace else tail remainderWithSpace

firstSen = "Tyger Tyger, burning bright\n"
secondSen = "In the forests of the night\n"
thirdSen = "What immortal hand or eye\n"
fourthSen = "Could frame thy fearful symmetry?"
sentences = firstSen ++ secondSen ++ thirdSen ++ fourthSen


myLines :: String -> [String]

myLines string
  | chunk == [] = []
  | otherwise   = chunk : (myLines remainder)
  where
    chunk = takeWhile (not . (== '\n')) string
    remainderWithSpace = dropWhile (not . (== '\n')) string
    remainder = if remainderWithSpace == [] then remainderWithSpace else tail remainderWithSpace

mySplit :: String -> [String]

mySplit string character
  | chunk == [] = []
  | otherwise   = chunk : (mySplit remainder)
  where
    chunk = takeWhile (not . (== character)) string
    remainderWithSpace = dropWhile (not . (== character)) string
    remainder = if remainderWithSpace == [] then remainderWithSpace else tail remainderWithSpace
