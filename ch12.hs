module Ch11 where
  import Data.List

  -- 2. This is the 𝑎 argument to ValidatePerson type.
  -- Why PersonInvalid instead of AgeInvalid

{-|

1. Given
id :: a -> a
What is the kind of a?
*
2. r :: a -> f a
What are the kinds of a and f?
f :: * -> *
a :: *

-}  

  split :: Eq a => [a] -> [a] -> [[a]]
  split delim xs   = go delim xs []
    where
    go :: Eq a => [a] -> [a] -> [a] -> [[a]]
    go _ [] []       = []
    go _ [] part     = [reverse part]
    go [] (x:xs) []  = [[x]] ++ (go [] xs [])
    go delim xs part = 
      if delim_match == delim then
        case remainder of
          []        -> [reverse part]
          something -> [reverse part] ++ (go delim (drop delim_len xs) [])
      else
        go delim (tail xs) ((head xs) : part)
      where 
        delim_match = take delim_len xs
        delim_len = length delim
        remainder = drop delim_len xs

  join :: [a] -> [[a]] -> [a]
  join _ []         = []
  join delim (x:[]) = x
  join delim (x:xs) = x ++ delim ++ (join delim xs)

  notThe :: String -> Maybe String 
  notThe xs = 
    if xs == "the" then
      Just xs
    else
      Nothing

  replaceThe :: String -> String
  replaceThe = join "a" . split "the"

  countTheBeforeVowel :: String -> Int
  countTheBeforeVowel xs = 
    length $ filter wordHasVowel wordsAfterThe
      where
      wordHasVowel :: String -> Bool
      wordHasVowel (x:xs) =
        if x == ' ' then wordHasVowel xs
        else isVowel x
      wordHasVowel []     = False
      words               = split "the" xs
      wordsAfterThe       = 
        if length words > 0 then tail words 
        else [] 

  isVowel :: Char -> Bool
  isVowel x = 
    case elemIndex x "aeiouAEIOU" of
      Just _  -> True
      Nothing -> False

-- (f . g) x == f $ g x

-- needed to use Int here
  countVowels :: String -> Int
  countVowels = length . filter isVowel

  newtype Word' =
    Word' String deriving (Eq, Show)
  
  vowels = "aeiou"

  mkWord :: String -> Maybe Word'
  mkWord word = 
    if numVowels > numCons then 
      Nothing
    else
      Just (Word' word)
    where
    numVowels = countVowels word
    numCons = length word - numVowels

  data Nat =
      Zero
    | Succ Nat
    deriving (Eq, Show)

  natToInteger :: Nat -> Integer
  natToInteger Zero   = 0
  natToInteger (Succ x) = 1 + natToInteger x

  integerToNat :: Integer -> Maybe Nat
  integerToNat x 
    | x < 0     = Nothing
    | x == 0    = Just Zero
    | otherwise = 
      case integerToNat (x - 1) of
        Just y  -> Just (Succ y)
        Nothing -> Nothing

-- Write the following functions. This may take some time. 
-- 1. Simple boolean checks for Maybe values.
-- >>> isJust (Just 1)
-- True
-- >>> isJust Nothing
-- False
  isJust :: Maybe a -> Bool
  isJust (Just a) = True
  isJust Nothing  = False


  -- >>> isNothing (Just 1)
  -- False
  -- >>> isNothing Nothing
  -- True
  isNothing :: Maybe a -> Bool
  isNothing = not . isJust

  -- >>> mayybee 0 (+1) Nothing
  -- 0
  -- >>> mayybee 0 (+1) (Just 1)
  -- 2
  mayybee :: b -> (a -> b) -> Maybe a -> b
  mayybee _ f (Just a) = f a
  mayybee z _ Nothing  = z

  fromMaybe :: a -> Maybe a -> a
  fromMaybe z (Just a) = a
  fromMaybe z Nothing  = z

  fromMaybeNoDefault :: Maybe a -> a
  fromMaybeNoDefault (Just a) = a
  fromMaybeNoDefault Nothing  = undefined

  listToMaybe :: [a] -> Maybe a
  listToMaybe []   = Nothing
  listToMaybe (x:xs) = Just x

  maybeToList :: Maybe a -> [a]
  maybeToList Nothing = []
  maybeToList (Just a)  = [a]

  -- >>> catMaybes [Just 1, Nothing, Just 2]
     -- [1, 2]
     -- >>> let xs = take 3 $ repeat Nothing
     -- >>> catMaybes xs
  -- []
  catMaybes :: [Maybe a] -> [a]
  catMaybes = map fromMaybeNoDefault . filter isJust

   -- >>> flipMaybe [Just 1, Just 2, Just 3]
   -- Just [1, 2, 3]
   -- >>> flipMaybe [Just 1, Nothing, Just 3]
   -- Nothing
  flipMaybe :: [Maybe a] -> Maybe [a]
  flipMaybe xs = 
    if length xs == length justs then Just justs
    else Nothing
    where
      justs = catMaybes xs

{-|
1. Try to eventually arrive at a solution that uses foldr, even if earlier versions don’t use foldr.
-}

  takeLeft :: Either a b -> Maybe a
  takeLeft (Left a) = Just a
  takeLeft _      = Nothing

  lefts' :: [Either a b] -> [a]
  lefts' = catMaybes . map takeLeft

  lefts'' :: [Either a b] -> [a]
  lefts'' = foldr f []
    where
      f a b = 
        case a of
          Left c  -> c:b
          Right _ -> b

  rights' :: [Either a b] -> [b]
  rights' = foldr f []
    where
      f a b = 
        case a of
          Right c  -> c:b
          Left _ -> b

  partitionEithers' :: [Either a b] -> ([a], [b])
  partitionEithers' xs = (lefts'' xs, rights' xs)

  eitherMaybe' :: (b -> c) -> Either a b -> Maybe c
  eitherMaybe' f (Right b) = Just (f b)
  eitherMaybe' _ _         = Nothing


  either' :: (a -> c) -> (b -> c) -> Either a b -> c
  either' _ f (Right b) = f b
  either' f _ (Left a)  = f a

-- this is bad

  eitherMaybe'' :: (b -> c) -> Either a b -> Maybe c
  eitherMaybe'' f x@(Right b) = Just (either' z f x)
    where
      z :: a -> c
      z _ = undefined
  eitherMaybe'' _ (Left a)    = Nothing

  myIterate :: (a -> a) -> a -> [a]
  myIterate f a = b:(myIterate f b) where b = f a

  myUnfoldr :: (b -> Maybe (a, b)) -> b -> [a]
  myUnfoldr f b = case f b of
    Just (a, b') -> a:(myUnfoldr f b')
    Nothing      -> []

  betterIterate :: (a -> a) -> a -> [a]
  betterIterate f = myUnfoldr (\b -> Just (b, f b))

  data BinaryTree a = 
      Leaf
    | Node (BinaryTree a) a (BinaryTree a)
    deriving (Eq, Ord, Show)

  unfold :: (a -> Maybe (a,b,a))
         -> a
         -> BinaryTree b
  unfold f a = 
    case b of
      Just (left_a, b', right_a) -> Node (unfold f left_a) b' (unfold f right_a)
      Nothing                    -> Leaf
      where b = f a

  treeBuild :: Integer -> BinaryTree Integer
  treeBuild n = unfold f 0
    where f x = if x >= n then Nothing else Just (x+1, x, x+1)
