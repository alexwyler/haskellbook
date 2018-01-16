module Main where

  import Control.Monad (forever) -- [1]
  import Data.Char (toLower) -- [2] 
  import Data.Maybe (isJust, fromMaybe) -- [3] 
  import Data.List (intersperse) -- [4] 
  import System.Exit (exitSuccess) -- [5] 
  import System.Random (randomRIO) -- [6]

  newtype WordList = 
    WordList [String]
    deriving (Eq, Show)

  data Puzzle =
    Puzzle String [Maybe Char] [Char]

  instance Show Puzzle where
    show (Puzzle _ discovered guessed) =
      (intersperse ' ' $
      fmap renderPuzzleChar discovered)
      ++ " Guessed so far: " ++ guessed

  freshPuzzle :: String -> Puzzle
  freshPuzzle word = Puzzle word (map (\_ -> Nothing) word) []

  charInWord :: Puzzle -> Char -> Bool
  charInWord (Puzzle word _ _) c = elem c word

  alreadyGuessed :: Puzzle -> Char -> Bool
  alreadyGuessed (Puzzle _ _ guessed) c = elem c guessed

  renderPuzzleChar :: Maybe Char -> Char
  renderPuzzleChar = fromMaybe '_'

  fillInCharacter :: Puzzle -> Char -> Puzzle
  fillInCharacter (Puzzle word filledInSoFar s) c = -- [2]
    Puzzle word newFilledInSoFar (c:s) -- [3]
    where
      zipper guessed wordChar guessChar = -- [4] [5] [6] [7]
        if wordChar == guessed
        then Just wordChar
        else guessChar
      newFilledInSoFar = -- [9]
        zipWith (zipper c)
          word filledInSoFar -- [ 10 ]

  allWords :: IO WordList
  allWords = do
    dict <- readFile "data/dict.txt"
    return $ WordList (lines dict)

  minWordLength :: Int
  minWordLength = 5 

  maxWordLength :: Int
  maxWordLength = 9

  gameWords :: IO WordList
  gameWords = do
    (WordList aw) <- allWords
    return $ WordList (filter gameLength aw)
    where
      gameLength w =
        let l = length (w :: String)
        in   l >= minWordLength
          && l < maxWordLength

  randomWord :: WordList -> IO String
  randomWord (WordList wl) = do
    randomIndex <- randomRIO (0 , length wl - 1) -- fill this part in ^^^
    return $ wl !! randomIndex

  randomWord' :: IO String
  randomWord' = gameWords >>= randomWord

  handleGuess :: Puzzle -> Char -> IO Puzzle
  handleGuess puzzle guess = do
    putStrLn $ "Your guess was: " ++ [guess]
    case (charInWord puzzle guess
        , alreadyGuessed puzzle guess) of
      (_, True) -> do
        putStrLn "You already guessed that\
                  \ character, pick \
                  \ something else!"
        return puzzle
      (True, _) -> do
        putStrLn "This character was in the\
                  \ word, filling in the word\
                  \ accordingly"
        return (fillInCharacter puzzle guess)
      (False, _) -> do
        putStrLn "This character wasn't in\
                  \ the word, try again."
        return (fillInCharacter puzzle guess)

  gameOver :: Puzzle -> IO ()
  gameOver p@(Puzzle wordToGuess _ guessed) =
    if (length guessesNotInWord) > 5 then
      do putStrLn "You lose!"
         putStrLn $
           "The word was: " ++ wordToGuess
         exitSuccess
    else return ()
    wheres
      guessesNotInWord = filter (not . charInWord p) guessed

  gameWin :: Puzzle -> IO ()
  gameWin (Puzzle _ filledInSoFar _) =
    if all isJust filledInSoFar then
      do putStrLn "You win!"
         exitSuccess
    else return ()

  runGame :: Puzzle -> IO ()
  runGame puzzle = forever $ do
    gameOver puzzle
    gameWin puzzle
    putStrLn $
      "Current puzzle is: " ++ show puzzle
    putStr "Guess a letter: "
    guess <- getLine
    case guess of
      [c] -> handleGuess puzzle c >>= runGame
      _   ->
             putStrLn "Your guess must\
                     \ be a single character"

  main :: IO ()
  main = do
    word <- randomWord'
    let puzzle =
          freshPuzzle (fmap toLower word)
    runGame puzzle
