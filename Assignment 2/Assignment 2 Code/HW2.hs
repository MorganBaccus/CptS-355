-- CptS 355 - Spring 2022 -- Homework2 - Haskell
-- Name: Morgan Baccus
-- Collaborators: 

module HW2
     where

-- P1 - commons, commons_tail, and commons_all 
-- (a) commons – 5%
commons :: Eq a => [a] -> [a] -> [a]
commons l1 [] = []
commons [] l2 = []
commons l1 l2 = eliminateDuplicates( (filter (\x -> x `elem` l2) l1))
     where
          eliminateDuplicates:: Eq a => [a] -> [a]
          eliminateDuplicates [] = []
          eliminateDuplicates (x:xs)
               | elem x xs = eliminateDuplicates xs
               | otherwise = x:(eliminateDuplicates xs)

-- (b) commons_tail –  9%
commons_tail :: Eq a => [a] -> [a] -> [a]
commons_tail l1 l2 = eliminateDuplicates( helper l1 l2 [] )
     where
          eliminateDuplicates [] = []
          eliminateDuplicates (x:xs)
               | elem x xs = eliminateDuplicates xs
               | otherwise = x:(eliminateDuplicates xs)
          helper l1 [] acc = acc
          helper [] l2 acc = acc
          helper (x:xs) l2 acc
               | x `elem` l2 = helper xs l2 (x:acc)
               | otherwise = helper xs l2 acc

-- (c) commons_all –  3%
commons_all:: Eq a => [[a]] -> [a]
commons_all [[]] = []
commons_all list = foldl1 commons list

------------------------------------------------------
-- P2  find_languages and find_courses 
-- (a) find_languages – 10%
find_languages::(Eq a1, Eq a2) => [(a2, [a1])] -> [a2] -> [a1]
find_languages list courses = commons_all (filter_courses list courses)
     where
          filter_courses [] courses = []
          filter_courses list [] = []
          filter_courses list courses = map snd (filter ((`elem` courses).fst) list)

-- (b) find_courses – 12%
find_courses :: Eq t1 => [(a, [t1])] -> [t1] -> [(t1,[a])]
find_courses courses langs = zip langs (filterCourses langs courses)
     where
          filterCourses langs courses = [[course | (course, langs) <- courses, lang `elem` langs] | lang <- langs]


------------------------------------------------------
-- P3  nested_max, max_maybe, and max_numbers
-- (a) nested_max - 2%
nested_max :: [[Int]] -> Int
nested_max [] = minBound::Int
nested_max list = maxL (map maxL list)
     where
          maxL xs = foldr gt (minBound::Int) xs
          gt x y = if x < y then y else x

-- (b) max_maybe - 8%
max_maybe :: Ord a => [[Maybe a]] -> Maybe a
max_maybe [] = Nothing
max_maybe list = foldr1 max (foldr1 (++) list)

-- (c) max_numbers - 8%
data Numbers = StrNumber String | IntNumber Int
               deriving (Show, Read, Eq)

max_numbers :: [[Numbers]] -> Int
max_numbers = max1 . map max2
     where
          max2 = max1 . map getInt
          getInt :: Numbers -> Int
          getInt (StrNumber x) = read x
          getInt (IntNumber x) = x
          max1 :: (Bounded a, Ord a) => [a] -> a
          max1 [] = minBound
          max1 list
                    | null list    = minBound
                    | otherwise = maximum list


------------------------------------------------------
-- P4  tree_scan, tree_search, merge_trees
data Tree a = LEAF a | NODE a (Tree a) (Tree a)
               deriving (Show, Read, Eq)

-- (a) tree_scan 5%
tree_scan :: Tree a -> [a]
tree_scan (LEAF t1) = [t1]
tree_scan (NODE a t1 t2) = tree_scan t1 ++ [a] ++ tree_scan t2

-- (b) tree_search 12%
tree_search :: (Ord p, Num p, Eq a) => Tree a -> a -> p
tree_search (LEAF a) n
     | (n == a) = 1
     | otherwise = -1
tree_search (NODE t t1 t2) n  = tree_search_helper (NODE t t1 t2) n 1
     where
          tree_search_helper (NODE t t1 t2) n x
               | (t == n) = x
               | otherwise = max (tree_search_helper t1 n (x+1)) (tree_search_helper t2 n (x+1))
          tree_search_helper (LEAF a) n x
               | (a == n) = x
               | otherwise =  -1


-- (c) merge_trees  14%
merge_trees :: Num a => Tree a -> Tree a -> Tree a
merge_trees (LEAF a) (LEAF b) = LEAF (a + b)
merge_trees (LEAF a) (NODE b left right) = NODE (a + b) left right
merge_trees (NODE b left right) (LEAF a) = NODE (a + b) left right
merge_trees (NODE a left right) (NODE b left1 right1) = NODE new left2 right2
     where
          new = a + b
          left2 = merge_trees left left1
          right2 = merge_trees right right1