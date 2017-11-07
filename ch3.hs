module Print1 where

  main :: IO ()
  main = putStrLn "hello world!"

  main2 :: IO () 
  main2 = do
    putStrLn "Count to four for me:"
    putStr   "one, two"
    putStr   ", three, and"
    putStrLn " four!"

  myGreeting :: String
  myGreeting = "hello" ++ " world!"

  hello :: String
  hello = "hello"

  world :: String
  world = "world!"
  
  main3 :: IO ()
  main3 = do
    putStrLn myGreeting
    putStrLn secondGreeting 
    where secondGreeting = 
            concat [hello, " ", world]


  topLevelFunction :: Integer -> Integer
  topLevelFunction x =
    x + woot + topLevelValue
    where woot :: Integer
          woot = 10

  topLevelValue :: Integer
  topLevelValue = 5

{-|
Excercises: Scope

1. 
Prelude> let x = 5
Prelude> let y = 7
Prelude> let z = x * y
Is 𝑦 in scope for 𝑧? Yes

2. 
Prelude> let f = 3
Prelude> let g = 6 * f + h
Is h in scope for 𝑔? No

3.
  area d = pi * (r * r)
  r = d / 2
Is everything we need to execute area in scope? No. "error: Variable not in scope: d"

4.
-}
  area2 d = pi * (r * r)
    where r = d / 2
{-|
Now are 𝑟 and 𝑑 in scope for area? Yes, even pi.
-}

{-|
Exercises: Syntax Errors

1. ++ [1, 2, 3] [4, 5, 6]
Yes

2. '<3' ++ ' Haskell'
No, not Chars

3. concat ["<3", " Haskell"]
Yes

-}

  myGreeting2 :: String
  myGreeting2 = (++) "hello" " world!"

  hello2 :: String
  hello2 = "hello"
  
  world2 :: String
  world2 = "world!"
  
  main4 :: IO ()
  main4 = do
    putStrLn myGreeting2
    putStrLn secondGreeting2 where 
      secondGreeting2 =
        (++) hello2 ((++) " " world2)
    -- could've been:
    --     secondGreeting =
   --       hello ++ " " ++ world

  printSecond :: IO ()
  printSecond = do
    putStrLn greeting
  
  -- greeting must be top level
  greeting = "Yarrrrr"

  main5 :: IO ()
  main5 = do
    putStrLn greeting 
    printSecond
{-|
Reading syntax

1.
a) concat [[1, 2, 3], [4, 5, 6]] 
Correct

b) ++ [1, 2, 3] [4, 5, 6]
Incorrect
[1, 2, 3] ++ [4, 5, 6]

c) (++) "hello" " world"
Correct

d) ["hello" ++ " world] 
Incorrect
["hello" ++ " world"] 

e) 4 !! "hello"
Incorrect
"hello" !! 4

f) (!!) "hello" 4
Correct

g) take "4 lovely"
Incorrect
take 4 "lovely"

h) take 3 "awesome"
Correct

2.
a) concat [[1 * 6], [2 * 6], [3 * 6]]
[6, 12, 36]

b) "rain" ++ drop 2 "elbow"
"rainbow"

c) 10 * head [1, 2, 3]
10

d) (take 3 "Julie") ++ (tail "yes")
"Jules"

e) concat [tail [1, 2, 3], tail [4, 5, 6], tail [7, 8, 9]]
[2, 3, 5, 6, 8, 9]


Building functions

1.
-- If you apply your function
-- to this value:
"Hello World"
-- Your function should return: 
"ello World"


Prelude> drop 1 "Hello World"
"ello World"

a)
-- Given
"Curry is awesome" 
-- Return
"Curry is awesome!"

> "Curry is awesome" ++ "!"

b)
-- Given
"Curry is awesome!"
-- Return
"y"

> ["Curry is awesome" !! 4]

c)
-- Given
"Curry is awesome!"
-- Return "awesome!"

> drop 9 "Curry is awesome!" 
-}

-- 2

-- a
  exclaim s = s ++ "!"

-- b
  index4Str s = [s !! 4]

-- c
  drop9 s = drop 9 s

-- 3
  thirdLetter :: String -> Char
  thirdLetter x = x !! 3

-- 4
  letterIndex :: Int -> Char
  letterIndex x = "curry is awesome" !! x

-- 5
  rvrs :: String -> String
  rvrs s = awesome ++ " " ++ is ++ " " ++ curry where
    isAwesome = drop 6 s
    awesome = drop 3 isAwesome
    is = take 2 isAwesome
    curry = take 5 s

-- 6
  main6 :: IO ()
  main6 = print (rvrs "Curry is awesome")

