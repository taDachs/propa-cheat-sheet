# Haskell
Haskell is great.

## General Haskell stuff
```haskell

-- type definitions are right associative
foo :: (a -> (b -> (c -> d)))
-- function applications are left associative
((((foo a) b) c) d)

-- guards are unnecessary if you know how pattern matching works
foo x y
  | x > y = "shit"
  | x < y = "piss"
  | x == y = "arschsekretlecker"
  | default = "love"

-- case of does pattern matching so its okay
foo x = case x of
          [] -> "fleischpenis"
          [1] -> "kokern"
          (420:l) -> "pimpern"

-- list comprehension is not as good as in python
[foo x | x <- [1..420], x `mod` 2 == 0]

[0..5] == [0,1,2,3,4,5]

-- alias for pattern matching
foo l@(x:xs) = l == (x:xs) -- returns true

-- combine two functions
f :: a -> b
g :: b -> c

h :: a -> c
h = f . g

data Tree a = Leaf
              | Node (Tree a) a (Tree a)
              deriving (Show)

-- defines interface
class Eq t where
  (==) :: t -> t -> Bool
  (/=) :: t -> t -> Bool
  -- default implementation
  x /= y = not $ x == y

-- extends interface
class (Show t) => B t where
  foo :: (B t) -> String

-- implement interface
instance Eq Bool where
  True == True = True
  False == False = True
  True == False = False
  False == True = False
```

## Important functions
```haskell
-- maps a function to a list
map :: (a -> b) -> [a] -> [b]
-- filters a list with a predicate
filter :: (a -> Bool) -> [a] -> [a]
-- fold from left
foldl :: Foldable t => (b -> a -> b) -> b -> t a -> b
-- fold from right
foldr :: Foldable t => (a -> b -> b) -> b -> t a -> b
-- checks if a in collection
elem :: (Foldable t, Eq a) => a -> t a -> Bool
-- in a list of type [(key, value)]  returns first element where key matches given value
lookup :: Eq a => a -> [(a, b)] -> Maybe b
-- repeated application of function
iterate :: (a -> a) -> a -> [a]
-- repeats constant in infinite list
repeat :: a -> [a]
-- applies function until the predicate is true
until :: (a -> Bool) -> (a -> a) -> a -> a
-- returns true if the predicate is true for at least one element
any :: Foldable t => (a -> Bool) -> t a -> Bool
-- return true if the predicate is true for all elements
all :: Foldable t => (a -> Bool) -> t a -> Bool
-- flips the parameters of a function
flip :: (a -> b -> c) -> b -> a -> c
-- combines two lists to a list of tuples
zip :: [a] -> [b] -> [(a, b)]
-- splits the list into to. The first list contains n elements.
splitAt :: Int -> [a] -> ([a], [a])
```

