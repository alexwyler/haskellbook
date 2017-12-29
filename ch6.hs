module Ch6 where

  data Trivial =
    Trivial' deriving Show

  instance Eq Trivial where
    Trivial' == Trivial' = True

  data DayOfWeek =
    Mon | Tue | Weds | Thu | Fri | Sat | Sun deriving Show

-- So separating 3 types means its a tuple?
  data Date =
    Date DayOfWeek Int deriving Show

  instance Eq DayOfWeek where
    (==) Mon Mon   = True 
    (==) Tue Tue   = True 
    (==) Weds Weds = True
    (==) Thu Thu   = True
    (==) Fri Fri   = True
    (==) Sat Sat   = True
    (==) Sun Sun   = True
    (==) _   _     = False

  instance Eq Date where
    (==)  (Date weekday dayOfMonth)
          (Date weekday' dayOfMonth') = 
            weekday    == weekday'
         && dayOfMonth == dayOfMonth'

  data Identity a = 
    Identity a

  instance Eq a => Eq (Identity a) where
    (==) (Identity v) (Identity v') = v == v'

{-
Exercises: Eq Instances
|-}

  data TisAnInteger =
    TisAn Integer

  instance Eq TisAnInteger where
    (==) (TisAn a) (TisAn b) = a == b

  data TwoIntegers =
       Two Integer Integer

  instance Eq TwoIntegers where
    (==) (Two a b) (Two c d) = a == c && b == d

  data StringOrInt = 
      TisAnInt Int
    | TisAString String
  
  instance Eq StringOrInt where
    (==) (TisAnInt a) (TisAnInt b) = a == b
    (==) (TisAString a) (TisAString b) = a == b
    (==) _ _ = False

  data Pair a =
    Pair a a

  instance Eq a => Eq (Pair a) where
    (==) (Pair b c) (Pair d e) = b == d && c == e

{-
Ch6.hs:66:15: error:
    • Expecting one more argument to ‘Pair’
      Expected a type, but ‘Pair’ has kind ‘* -> *’
    • In the first argument of ‘Eq’, namely ‘Pair’
      In the instance declaration for ‘Eq Pair’
Failed, modules loaded: none.
|-}

  data Tuple a b =
    Tuple a b

  instance (Eq a, Eq b) => Eq (Tuple a b) where
    (==) (Tuple a b) (Tuple a' b') = a == a' && b == b'

  data Which a = 
    ThisOne a | ThatOne a

  instance Eq a => Eq (Which a) where
    (==) (ThisOne x) (ThisOne x') = x == x'
    (==) (ThatOne x) (ThisOne x') = x == x'
    (==) _ _ = False

--    (==) (ThisOne x) (ThatOne x') = x == x'
--    (==) (ThatOne x) (ThisOne x') = x == x'
{-
Ch6.hs:91:5: warning: [-Woverlapping-patterns]
    Pattern match is redundant
    In an equation for ‘==’: == (ThatOne x) (ThisOne x') = ...
|-}

  data EitherOr a b = 
    Hello a | Goodbye b

  instance (Eq a, Eq b) => Eq (EitherOr a b) where
    (==) (Hello x) (Hello x') = x == x'
    (==) (Goodbye x) (Goodbye x') = x == x'
    (==) _ _ = False


