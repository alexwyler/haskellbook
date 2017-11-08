module Ch4 where
{-|

Exercises: Find the Mistakes
1. not True && true
False

2. not (x = 6)
not (x == 6)
True

3. (1 * 2) > 5
False

4. [Merry] > [Happy]
["Merry"] > ["Happy"]
True

5. [1, 2, 3] ++ "look at me!"
['1', '2', '3'] ++ "look at me!"
"123look at me!"


Excercises
8. Palindrome

-}
-- 8
  isPalindrome :: (Eq a) => [a] -> Bool
  isPalindrome x = reverse x == x

-- 9
  myAbs :: Integer -> Integer
  myAbs x = if x > 0 then x else -x

-- 10
  f :: (a, b) -> (c, d) -> ((b, d), (a, c))
  f x y = ((snd x, snd y ), (fst x, fst y))

  