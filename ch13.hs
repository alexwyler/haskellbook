module Ch13 where
  import Data.Char
  import Control.Monad
  import System.Exit (exitSuccess)


  {-|

1. What functions are being imported from Control.Monad? 
forever, when

2. Which imports are both unqualified and imported in their entirety?
Data.Bits Database.Blacktip.Types

3. From the name, what do you suppose importing blacktip’s Types module brings in?
Database column types

4. Now let’s compare a small part of blacktip’s code to the above import list:

a) The type signature refers to three aliased imports. What modules are named in those aliases?
Control.Concurrent.MVar Filesystem.Path.CurrentOS Control.Concurrent

b) Which import does FS.writeFile refer to? 
Filesystem

c) Which import did forever come from?
Control.Monad
  -}

  vCipher :: String -> String -> String
  vCipher text key = 
      [doOffset a b | (a, b) <- zipped]
    where
      zipped = zip text (cycle key)
      doOffset a b = 
        chr (wrappedSum + startInt)
        where
          aInt       = (ord a) - startInt
          bInt       = (ord b) - startInt
          sum'       = (aInt + bInt)
          wrappedSum = mod sum' 26
          startInt   = ord 'A'

  vCipherMain :: IO ()
  vCipherMain = do
    putStr "Text to cipher: "
    text <- getLine
    putStr "Key: "
    key <- getLine
    putStrLn $ vCipher text key


  palindrome :: IO ()
  palindrome = forever $ do
    line1 <- getLine
    let 
      strippedLine = filter (\c -> elem c ['a'..'z']) (map toLower line1) in
      case (strippedLine == reverse strippedLine) of
        True -> putStrLn "It's a palindrome!"
        False -> do
          putStrLn "Nope!"
          exitSuccess


  type Name = String
  type Age = Integer
  
  data Person = Person Name Age
    deriving Show

  data PersonInvalid =
      NameEmpty
    | AgeTooLow
    | PersonInvalidUnknown String 
    deriving (Eq, Show)
     
  mkPerson :: Name -> Age -> Either PersonInvalid Person
  mkPerson name age
    | name /= "" && age > 0 = 
      Right $ Person name age
    | name == "" = Left NameEmpty
    | not (age > 0) = Left AgeTooLow
    | otherwise =
      Left $ PersonInvalidUnknown $ 
        "Name was: " ++ show name ++ 
        " Age was: " ++ show age

  gimmePerson :: IO ()
  gimmePerson = do
    putStr "Name: "
    name <- getLine
    putStr "Age: "
    ageStr <- getLine
    case mkPerson name ((read ageStr) :: Integer) of
      Right p@(Person _ _)            -> putStrLn $ "Yay! Successfully got a person: " ++ show p
      Left NameEmpty                  -> putStrLn "Error. Name empty."
      Left AgeTooLow                  -> putStrLn "Error. Age too low."
      Left (PersonInvalidUnknown err) -> putStrLn $ "Error. " ++ err
    exitSuccess


