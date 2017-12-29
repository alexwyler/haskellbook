{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}

module Ch11 where
  import Data.Int
  import Data.Char
  import Data.Maybe
  import Data.List

  data Doggies a = 
    Husky a
    | Mastiff a
    deriving (Eq, Show)

  data DogueDeBordeaux doge =
    DogueDeBordeaux doge
{-|

Exercises: Dog Types
1. Is Doggies a type constructor or a data constructor?
type constructor

2. What is the kind of Doggies?
Doggies :: * -> *

3. What is the kind of Doggies String?
*

4. What is the type of Husky 10?
Num a => Doggies a

5. What is the type of Husky (10 :: Integer)? 
Doggies Integer

6. What is the type of Mastiff "Scooby Doo"?
Doggies String

7. Is DogueDeBordeaux a type constructor or a data constructor?
both

9. What is the type of DogueDeBordeaux "doggie!"
DogueDeBordeaux String
  
-}
  data Price =
    Price Integer 
    deriving (Eq, Show)

  data Manufacturer =
    Mini
    | Mazda
    | Tata
    deriving (Eq, Show)

  data Airline =
    PapuAir
    | CatapultsR'Us
    | TakeYourChancesUnited
    deriving (Eq, Show)

  data Vehicle = 
    Car Manufacturer Price
    | Plane Airline
    deriving (Eq, Show)

  myCar = Car Mini (Price 14000)
  urCar = Car Mazda (Price 20000)
  clownCar = Car Tata (Price 7000)
  doge = Plane PapuAir

{-|
Exercises: Vehicles
1. What is the type of myCar?
Vehicle
-}

  isCar :: Vehicle -> Bool
  isCar (Car _ _) = True
  isCar _         = False

  isPlane :: Vehicle -> Bool
  isPlane a = not (isCar a)
  
  areCars :: [Vehicle] -> [Bool]
  areCars xs = map isCar xs

  getManu :: Vehicle -> Manufacturer
  getManu (Car a _) = a
  getManu _         = undefined


  data Example = MakeExample Int deriving Show

  class TooMany a where
    tooMany :: a -> Bool

  instance TooMany Int where
    tooMany n = n > 42

  newtype Goats = Goats Int
    deriving (Eq, Show, TooMany)

  newtype IntStringTuple = IntStringTuple (Int, String)
    deriving (Eq, Show)

  instance TooMany IntStringTuple where
    tooMany (IntStringTuple (a, _)) = a > 42

  instance TooMany (Int, String) where
    tooMany (a, _) = a > 42

  instance TooMany (Int, Int) where
    tooMany (a, b) = a + b > 42

  instance (Num a, TooMany a) => TooMany (a, a) where
    tooMany (a, b) = tooMany (a + b)
{-|
*Ch11> tooMany (IntStringTuple (50, "hello"))
True

*Ch11> tooMany (50 :: Int, "hello")
True

*Ch11> tooMany (10 :: Int, 40 :: Int)
True

3. ?????
<interactive>:87:1: error:
    • Overlapping instances for TooMany (Int, Int)
        arising from a use of ‘tooMany’
      Matching instances:
        instance (Num a, TooMany a) => TooMany (a, a)
          -- Defined at ch11.hs:112:12
        instance TooMany (Int, Int) -- Defined at ch11.hs:109:12
    • In the expression: tooMany (10 :: Int, 20 :: Int)
      In an equation for ‘it’: it = tooMany (10 :: Int, 20 :: Int)
-}
  data BigSmall =
    Big Bool
    | Small Bool
    deriving (Eq, Show)
  
  data NumberOrBool =
    Numba Int8
    | BoolyBool Bool
    deriving (Eq, Show)
{-|
Exercises: Pity the Bool
1. What is the cardinality  BigSmall?

  1 * 2 + 1 * 2 = 2 + 2 = 4

2. What is the cardinality of NumberOrBool?
  
  1 * 256 + 1 * 2 = 256 + 2 = 258

-}

  data QuantumBool = 
    QuantumTrue
    | QuantumFalse
    | QuantumBoth
    deriving (Eq, Show)

  data TwoQs =
    MkTwoQs QuantumBool QuantumBool
    deriving (Eq, Show)

-- So, what is the cardinality of TwoQs? 3 * 3 = 9

  data Person =
    Person { name :: String, age :: Int } 
    deriving (Eq, Show)

  --data Fiction = Fiction deriving Show
  
  --data Nonfiction = Nonfiction deriving Show

  {- data BookType =
    FictionBook Fiction
    | NonfictionBook Nonfiction
    deriving Show -}

  type AuthorName = String
  
  --data Author = Author (AuthorName, BookType)

  data Author =
    Fiction AuthorName
    | Nonfiction AuthorName
    deriving (Eq, Show)

  data FlowerType = 
    Gardenia
    | Daisy
    | Rose
    | Lilac
    deriving Show

  type Gardener = String

  data Garden =
    Garden Gardener FlowerType
    deriving Show
  {-|
  Exercises: How Does Your Garden Grow?

  What is the sum of products normal form of Garden?
  -}

  data Garden' =
      Gardenia' Gardener
    | Daisy' Gardener
    | Rose' Gardener
    | Lilac' Gardener
    deriving Show

  data GuessWhat =
    Chickenbutt deriving (Eq, Show)
  
  data Id a =
    MkId a deriving (Eq, Show)
  
  data Product a b =
    Product a b
    deriving (Eq, Show)
  
  data Sum a b = 
      First a
    | Second b
    deriving (Eq, Show)

  data RecordProduct a b = 
      RecordProduct { pfirst :: a
                    , psecond :: b }
      deriving (Eq, Show)

  newtype NumCow = 
    NumCow Int
    deriving (Eq, Show)
  
  newtype NumPig = 
    NumPig Int
    deriving (Eq, Show)
  
  data Farmhouse = 
    Farmhouse NumCow NumPig 
    deriving (Eq, Show)
  
  type Farmhouse' = 
    Product NumCow NumPig

  newtype NumSheep = 
    NumSheep Int
    deriving (Eq, Show)
  
  data BigFarmhouse =
    BigFarmhouse NumCow NumPig NumSheep
    deriving (Eq, Show)
  
  type BigFarmhouse' =
    Product NumCow (Product NumPig NumSheep)

  type Name = String
  type Age = Int
  type LovesMud = Bool

  type PoundsOfWool = Int

  data CowInfo = 
    CowInfo Name Age
    deriving (Eq, Show)

  data PigInfo =
    PigInfo Name Age LovesMud
    deriving (Eq, Show)

  data SheepInfo =
    SheepInfo Name Age PoundsOfWool
    deriving (Eq, Show)
  
  data Animal =
      Cow CowInfo
    | Pig PigInfo
    | Sheep SheepInfo
    deriving (Eq, Show)

  type Animal' =
    Sum CowInfo (Sum PigInfo SheepInfo)

  newtype Animal'' =
    Animal'' (Sum CowInfo (Sum PigInfo SheepInfo))

  trivialValue :: GuessWhat
  trivialValue = Chickenbutt

  idInt :: Id Integer
  idInt = MkId 10

  type Awesome = Bool
  
  person :: Product Name Awesome
  person = Product "Simon" True

  data Twitter =
    Twitter
    deriving (Eq, Show)
  
  data AskFm =
    AskFm
    deriving (Eq, Show)

  socialNetwork :: Sum Twitter AskFm
  socialNetwork = First Twitter

  data OperatingSystem =
      GnuPlusLinux
    | OpenBSDPlusNevermindJustBSDStill
    | Mac
    | Windows
    deriving (Eq, Show)
  
  data ProgLang =
      Haskell
    | Agda
    | Idris
    | PureScript
    deriving (Eq, Show)

  data Programmer =
    Programmer { os :: OperatingSystem
               , lang :: ProgLang }
    deriving (Eq, Show)

-- Write a function that generates all possible values of Programmer.

  allOperatingSystems :: [OperatingSystem]
  allOperatingSystems =
    [ GnuPlusLinux
    , OpenBSDPlusNevermindJustBSDStill 
    , Mac
    , Windows
    ]

  allLanguages :: [ProgLang]
  allLanguages =
    [Haskell, Agda, Idris, PureScript]

  allProgrammers :: [Programmer]
  allProgrammers = [Programmer os lang | os <- allOperatingSystems, lang <- allLanguages]

  data ThereYet =
    There Float Int Bool deriving (Eq, Show)

  -- do we need to define this???
  nope :: Float -> Int -> Bool -> ThereYet
  nope = There

  -- who needs a "builder pattern"?
  notYet :: Int -> Bool -> ThereYet
  notYet = nope 25.5
  
  notQuite :: Bool -> ThereYet
  notQuite = notYet 10
  
  yusssss :: ThereYet
  yusssss = notQuite False

  newtype Name'  = Name String deriving Show
  newtype Acres = Acres Int deriving Show
  
  -- FarmerType is a Sum
  data FarmerType = 
      DairyFarmer
    | WheatFarmer
    | SoybeanFarmer
    deriving Show

  data Farmer =
    Farmer Name' Acres FarmerType
    deriving Show

{-|
Given a function a -> b, we can calculate the inhabitants with the formula b ^ a

QuantumBool -> QuantumBool

True  -> True
False -> True
Both  -> True

True  -> True
False -> True
Both  -> False

True  -> True
False -> True
Both  -> Both

True  -> True
False -> False
Both  -> True

True  -> True
False -> False
Both  -> False

True  -> True
False -> False
Both  -> Both

True  -> True
False -> Both
Both  -> True

True  -> True
False -> Both
Both  -> False

True  -> True
False -> Both
Both  -> Both

...


-}


  data Quantum =
      Yes
    | No
    | Both
    deriving (Eq, Show)


  quantSum1 :: Either Quantum Quantum
  quantSum1 = Right Yes

  quantSum2 :: Either Quantum Quantum
  quantSum2 = Right No

  quantSum3 :: Either Quantum Quantum
  quantSum3 = Right Both

  quantSum4 :: Either Quantum Quantum
  quantSum4 = Left Yes

  quantSum5 :: Either Quantum Quantum
  quantSum5 = Left No

  quantSum6 :: Either Quantum Quantum
  quantSum6 = Left Both

  quantProd1 :: (Quantum, Quantum)
  quantProd1 = (Yes, Yes)

  quantProd2 :: (Quantum, Quantum)
  quantProd2 = (Yes, No)
  
  quantProd3 :: (Quantum, Quantum)
  quantProd3 = (Yes, Both)

  quantProd4 :: (Quantum, Quantum)
  quantProd4 = (No, Yes)

  quantProd5 :: (Quantum, Quantum)
  quantProd5 = (No, No)

  quantProd6 :: (Quantum, Quantum)
  quantProd6 = (No, Both)
  
  quantProd7 :: (Quantum, Quantum)
  quantProd7 = (Both, Yes)

  quantProd8 :: (Quantum, Quantum)
  quantProd8 = (Both, No)

  quantProd9 :: (Quantum, Quantum)
  quantProd9 = (Both, Both)

  convert1 :: Quantum -> Bool
  convert1 Yes  = False
  convert1 No   = False
  convert1 Both = False

  convert2 :: Quantum -> Bool
  convert2 Yes  = False
  convert2 No   = False
  convert2 Both = True

  convert3 :: Quantum -> Bool
  convert3 Yes  = False
  convert3 No   = True
  convert3 Both = False

  convert4 :: Quantum -> Bool
  convert4 Yes  = False
  convert4 No   = True
  convert4 Both = True

  convert5 :: Quantum -> Bool
  convert5 Yes  = True
  convert5 No   = False
  convert5 Both = False

  convert6 :: Quantum -> Bool
  convert6 Yes  = True
  convert6 No   = False
  convert6 Both = False

  convert7 :: Quantum -> Bool
  convert7 Yes  = True
  convert7 No   = False
  convert7 Both = True

  convert8 :: Quantum -> Bool
  convert8 Yes  = True
  convert8 No   = True
  convert8 Both = True

-- Excercies: The Quad
  data Quad =
      One
    | Two
    | Three
    | Four
    deriving (Eq, Show)

{-|
  1. how many different forms can this take?
  eQuad :: Either Quad Quad
  eQuad = undefined
  1 * 4 + 1 * 4 = 4 + 4 = 8

  2. prodQuad :: (Quad, Quad)
    4 * 4 = 16

  3. funcQuad :: Quad -> Quad
    4 ^ 4 = 256

  4. prodTBool :: (Bool, Bool, Bool)
    2 * 2 * 2 = 8

  5. gTwo :: Bool -> Bool -> Bool
    (2 ^ 2) ^ 2 = 16

  6. Hint: 5 digit number
       fTwo :: Bool -> Quad -> Quad
    (4 ^ 4) ^ 2 = 65536
-}

{-|
But in Haskell, we do not conventionally put constraints on datatypes. 
That is, we don’t want to constrain that polymorphic 𝑎 in the datatype. 
The FromJSON typeclass will likely (assuming that’s what is needed in a given context)
constrain the variable in the type signature(s) for the function(s) that will process this data.
-}

  data BinaryTree a = 
      Leaf
    | Node (BinaryTree a) a (BinaryTree a)
    deriving (Eq, Ord, Show)

  insert' :: Ord a => a -> BinaryTree a -> BinaryTree a

  insert' b Leaf = Node Leaf b Leaf
  insert' b (Node left a right)
    | b == a = Node left a right
    | b < a  = Node (insert' b left) a right
    | b > a  = Node left a (insert' b right)

  mapTree :: (a -> b) -> BinaryTree a -> BinaryTree b
  mapTree _ Leaf = Leaf
  mapTree f (Node left a right) = Node (mapTree f left) (f a) (mapTree f right)

  testTree' :: BinaryTree Integer
  testTree' =
    Node (Node Leaf 3 Leaf) 1 (Node Leaf 4 Leaf)
  
  mapExpected =
    Node (Node Leaf 4 Leaf) 2 (Node Leaf 5 Leaf)

  mapOkay =
    if mapTree (+1) testTree' == mapExpected then print "yup okay!"
    else error "test failed!"

  preorder :: BinaryTree a -> [a]
  preorder Leaf = []
  preorder (Node left a right) = [a] ++ (preorder left) ++ (preorder right)
  
  inorder :: BinaryTree a -> [a]
  inorder Leaf = []
  inorder (Node left a right) = (preorder left) ++ [a] ++ (preorder right)

  postorder :: BinaryTree a -> [a]
  postorder Leaf = []
  postorder (Node left a right) = (preorder left) ++ (preorder right) ++ [a]

  testTree :: BinaryTree Integer
  testTree = Node (Node Leaf 1 Leaf) 2 (Node Leaf 3 Leaf)

  testPreorder :: IO ()
  testPreorder =
    if preorder testTree == [2, 1, 3] then putStrLn "Preorder fine!" 
    else putStrLn "Bad news bears."
  
  testInorder :: IO ()
  testInorder =
    if inorder testTree == [1, 2, 3] then putStrLn "Inorder fine!"
    else putStrLn "Bad news bears."

  testPostOrder :: IO ()
  testPostOrder =
    if postorder testTree == [1, 3, 2] then putStrLn "Inorder fine!"
    else putStrLn "Bad news bears."

  -- any traversal order is fine
  foldTree :: (a -> b -> b) -> b -> BinaryTree a -> b
  foldTree f z x = foldr f z (inorder x)
  -- how to do it without converting to list?

{-|
1. Given the following datatype:
     data Weekday =
         Monday
       | Tuesday
       | Wednesday
       | Thursday
       | Friday

we can say:
a) Weekday is a type with five data constructors

2. and with the same datatype de nition in mind, what is
the type of the following function, f? 
f Friday = "Miller Time"
c) f :: Weekday -> String 

3. Types defined with the data keyword
b) must begin with a capital letter

4. The function g xs = xs !! (length xs - 1)
c) delivers the final element of xs 

-}

  vCipher :: String -> String -> String
  vCipher text key = 
      [doOffset letter offsetLetter | (letter, offsetLetter) <- zipped]
    where
      doOffset a b = 
        chr (wrappedSum + startInt)
        where
          aInt = (ord a) - startInt
          bInt = (ord b) - startInt
          sum' = (aInt + bInt)
          wrappedSum = mod sum' 26
          startInt = ord 'A'
      zipped = zip text (cycle  key)

{-|
*Ch11> vCipher "MEETATDOWN" "ALLY"
"MPPRAEOMWY"
-}

{-|
1. This should return True if (and only if) all the values in the  rst list appear in the second list, though they need not be contiguous.
-}

  isSubseqOf :: (Eq a) => [a] -> [a] -> Bool
  isSubseqOf _ [] = False
  isSubseqOf needle haystack@(x:xs) = 
    if needle == take (length needle) haystack then True
    else isSubseqOf needle xs

{-|
*Ch11> isSubseqOf "blah" "blahwoot"
True
*Ch11> isSubseqOf "blah" "blawoot"
False
-}

{-|
2. Split a sentence into words, then tuple each word with the capitalized form of each.
-}
  capitalizeWords :: String -> [(String, String)]
  capitalizeWords xs = [(word, capitalizeWord word) | word <- split xs ' ']

  capitalizeWord :: String -> String
  capitalizeWord ""     = ""
  capitalizeWord (x:xs) = 
    if x == ' ' then (" "  ++ capitalizeWord xs)
    else (toUpper x) : xs

  split :: String -> Char -> [String]
  split "" _       = []
  split xs delim   = 
    word : (split remainderClean delim)
    where
      word = takeWhile ((/=) delim) xs
      remainder = dropWhile ((/=) delim) xs
      remainderClean = if remainder == "" then "" else (tail remainder)

{-|
*Ch11> capitalizeWords "hello! man"
[("hello!","Hello!"),("man","Man")]
-}

  capitalizeParagraph :: String -> String
  capitalizeParagraph ""        = ""
  capitalizeParagraph paragraph = (capitalizeWord firstSentence) ++ "." ++ (capitalizeParagraph remainderClean)
    where
      firstSentence = takeWhile ((/=) '.') paragraph
      remainder = dropWhile ((/=) '.') paragraph
      remainderClean = 
        if remainder == "" then "" 
        else tail remainder

{-|
*Ch11> capitalizeParagraph "blah. woot ha."
"Blah. Woot ha."
-}

{-|
----------------------------------------- 
|1 |2ABC |3DEF | 
_________________________________________ 
|4GHI|5JKL |6MNO |
----------------------------------------- 
|7PQRS|8TUV |9WXYZ |
----------------------------------------- 
|*^|0+_|#., |
-----------------------------------------
Where star (*) gives you capitalization of the letter you’re writing to your friends, and 0 is your space bar.

1. Create a data structure that captures the phone layout above. 
The data structure should be able to express enough of how the layout works t
hat you can use it to dictate the behavior of the functions in the following exercises.
-}

  data DaPhone = 
    DaPhone [(Char,String)]
    deriving (Eq, Show)

  phone = DaPhone [
    ('1', []),
    ('2', "abc"),
    ('3', "def"),
    ('4', "ghi"),
    ('5', "jkl"),
    ('6', "mno"),
    ('7', "pqrs"),
    ('8', "tuv"),
    ('9', "wyxz"),
    ('0', " "),
    ('*', "^")]

  -- validButtons = "1234567890*#"
  type Digit = Char
  
  -- Valid presses: 1 and up
  type Presses = Int
  
  tapsForShift :: DaPhone -> (Digit, Presses)
  tapsForShift phone = head $ tapsForChar phone '^'

  tapsForChar :: DaPhone -> Char -> [(Digit, Presses)]
  tapsForChar (DaPhone ((digit, chars) : xs)) c =
    case isLower of
      True ->
        case indexOf of
          Nothing -> tapsForChar (DaPhone xs) c
          Just index -> [(digit, index + 1)] 
        where
          indexOf = elemIndex c chars
      False ->
        (tapsForShift phone) : (tapsForChar phone (toLower c))
    where
      isLower = toLower c == c
  tapsForChar _ _ = []


  tapsForSentence :: DaPhone -> String -> [(Digit, Presses)]
  tapsForSentence _ []         = []
  tapsForSentence phone (x:xs) = (tapsForChar phone x) ++ (tapsForSentence phone xs)

  --  -- assuming the default phone definition
  --  -- 'a' -> [('2', 1)]
  --  -- 'A' -> [('*', 1), ('2', 1)]

  convo :: [String]
  convo =
    ["Wanna play 20 questions",
     "Ya",
     "U 1st haha",
     "Lol ok. Have u ever tasted alcohol",
     "Lol ya",
     "Wow ur cool haha. Ur turn",
     "Ok. Do u think I am pretty Lol",
     "Lol ya",
     "Just making sure rofl ur turn"]

  tapsForConvo :: [[(Digit, Presses)]]
  tapsForConvo = map (tapsForSentence phone) convo

-- 3. How many times do digits need to be pressed for each message?

  sumTaps :: (Digit, Presses) -> Presses -> Presses
  sumTaps (_, a) b = a + b

  fingerTaps :: String -> Presses
  fingerTaps sentence = foldr sumTaps 0 (tapsForSentence phone sentence)

  mostPopularLetter :: String -> Char
  mostPopularLetter xs = fst $ foldr takeBigger ('a', 0) xs
    where
      counts = [(c, (countLetter xs c)) | c <- xs]
      takeBigger :: Char -> (Char, Int) -> (Char, Int)
      takeBigger c1 (c2, count2) = 
        case countAndChar of
          (_, count1) -> 
            if count1 > count2 then
            (c1, count1) else
            (c2, count2)
        where
          countAndChar = (c1, countLetter xs c1)

  countLetter :: String -> Char -> Int
  countLetter [] _ = 0
  countLetter xs c =
    case remainder == "" of
      True -> 0
      False -> 1 + (countLetter remainderClean c)
    where
      remainder = dropWhile ((/=) c) xs
      remainderClean = if remainder == "" then "" else tail remainder

  coolestLtr :: [String] -> Char
  coolestLtr sentences = 
    mostPopularLetter paragraph
    where
      paragraph = foldr (++) "" sentences

  mostPopularElement :: [String] -> String
  mostPopularElement l@(x:xs) = fst $ foldr takeBigger (x, 1) l
    where
      counts = [(c, (countElement l c)) | c <- l]
      takeBigger :: String -> (String, Int) -> (String, Int)
      takeBigger c1 (c2, count2) = 
        case countAndElement of
          (_, count1) -> 
            if count1 > count2 then
            (c1, count1) else
            (c2, count2)
        where
          countAndElement = (c1, countElement l c1)

  countElement :: [String] -> String -> Int
  countElement [] _ = 0
  countElement xs c =
    case remainder == [] of
      True -> 0
      False -> 1 + (countElement remainderClean c)
    where
      remainder = dropWhile ((/=) c) xs
      remainderClean = if remainder == [] then [] else tail remainder

  coolestWord :: [String] -> String
  coolestWord sentences = 
    mostPopularElement words
    where
      words = foldr concatWords [] sentences
      concatWords :: String -> [String] -> [String]
      concatWords sentence words = (split sentence ' ') ++ words

-- Hutton's Razor

  data Expr =
      Lit Integer
    | Add Expr Expr

  eval :: Expr -> Integer
  eval (Lit a)   = a
  eval (Add a b) = (eval a) + (eval b)

  printExpr :: Expr -> String
  printExpr (Lit a) = show a
  printExpr (Add a b) = (printExpr a) ++ " + " ++ (printExpr b)

