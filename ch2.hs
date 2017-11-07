module Ch2 where

{-|
Parenthization
1.
  2 + 2  * 3 - 1
  2 + (2 * 3) - 1
  2 + 6 - 1
  8 - 1
  7

2.
  (^) 10 $ 1 + 1
  (^) 10 2
  100

3.
  2 ^ 2 * 4 ^ 5 + 1
  4 * 1024 + 1
  4096 + 1
  4097

Equivalent Expressions
1.
  a. 1 + 1
     2
  b. 2
  (same)

2.
  a. 10 ^ 2
     100
  b. 10 + 9 * 10
     10 + 90
     100
  (same)

3.
  a. 400 - 37
     363
  b. (-) 37 400
     37 - 400
     -363
  (not same)

4.
  a. 100 `div` 3
     33
  b. 100 / 3
     33.33..
  (not same)

5.
  a. 2 * 5 + 18
     10 + 18
     28
  b. 2 * (5 + 18)
     2 * 23
     46
  (not same)

More fun with functions

z = 7
x = y ^ 2
waxOn = x * 5
y = z + 8

REPL:
let z = 7
let y = z + 8
let x = y ^ 2
let waxOn = x * 5

waxOn
x * 5
y ^ 2 * 5
(z + 8) ^ 2 * 5
(7 + 8) ^ 2 * 5
15 ^ 2 * 5
225 * 5
1125

1.
  a. 10 + waxOn
     1135
  b. (+10) waxOn
     1135
  c. (-) 15 waxOn
     -1110
  d. (-) waxOn 15
     1110

2.
let triple x = x * 3

3.
triple waxOn
3375

-}
-- 4.

waxOn = x * 5
  where
    z = 7
    x = y ^ 2
    y = z + 8

triple x = x * 3

waxOff x = triple x

waxOff2 x = (triple x) ^ 2 `div` 10




