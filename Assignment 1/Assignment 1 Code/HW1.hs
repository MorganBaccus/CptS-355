-- CptS 355 - Spring 2022 -- Homework1 - Haskell
-- Name: Morgan Baccus
-- Collaborators: 

module HW1
     where

-- P1 - list_diff 15%
list_diff :: Eq a => [a] -> [a] -> [a]
list_diff list1 list2 = (filter (\x -> x `notElem` list2) list1) ++ (filter (\x -> x `notElem` list1) list2)


-- P2  replace  15%
replace :: (Num t, Eq t, Eq a) => [a] -> a -> a -> t -> [a]
--replace :: (Ord t, Num t, Eq a) => [a] -> a -> a -> t -> [a]
replace [] v1 v2 n = []
replace list v1 v2 0 = list -- return the list unchanged
replace (x:xs) v1 v2 n
     | (x==v1) = v2:(replace xs v1 v2 (n-1))
     | otherwise = x:(replace xs v1 v2 n)


-- P3  max_date 10%
max_date :: (Num a1, Num a2, Num a3, Ord a1, Ord a2, Ord a3) => [(a2, a3, a1)] -> (a2, a3, a1)
max_date [] = (0,0,0)
max_date [x] = x
max_date (x:xs) = max_date_helper x (max_date xs)
     where
          max_date_helper (a,b,c) (x,y,z) = if (c>z)
                                                  then (a,b,c)
                                                  else if (z>c)
                                                       then (x,y,z)
                                                  else if (c==z) && (a>x)
                                                       then (a,b,c)
                                                  else if (c==z) && (x>a)
                                                       then (x,y,z)
                                                  else if (c==z) && (a==x) && (b>y)
                                                       then (a,b,c)
                                                  else if (c==z) && (a==x) && (y>b)
                                                       then (x,y,z)
                                                  else (a,b,c) -- same dates return either


-- P4  num_paths  10%
num_paths 1 n = 1
num_paths m 1 = 1
num_paths m n = (num_paths (m-1) n) + (num_paths m (n-1))


-- P5(a)  find_courses 10%
find_courses :: Eq t1 => [(a, [t1])] -> t1 -> [a]
find_courses [] a = []
find_courses ((name, list): xs) a
     | a `elem` list = name:(find_courses xs a)
     | otherwise = find_courses xs a

-- P5(b)  max_count  15%
max_count :: [(a1, [a2])] -> (a1, Int)
--max_count [] = ("0",0)
max_count [(name, list)] = (name, length list)
max_count ((a,b):(x,y):xs) = if (length b > length y)
                              then max_count ((a, b):xs)
                         else max_count ((x, y):xs)
max_count ((a,b):(x,y):[]) = if (length b > length y)
                              then (a, length b)
                         else (x, length y)


-- P6  split_at_duplicate 15%
split_at_duplicate :: Eq a => [a] -> [[a]]

split_at_duplicate [] = []
split_at_duplicate iL = split_at_duplicate_helper iL []
     where
          snoc x xs = xs ++ [x]
          split_at_duplicate_helper (x:y:xs) acc = if (x==y)
                                                       then (snoc x acc):(split_at_duplicate_helper (y:xs) []) 
                                                  else split_at_duplicate_helper (y:xs) (snoc x acc)
          split_at_duplicate_helper (x:y:[]) acc = if (x==y)
                                                       then [x:acc]
                                                  else [x:y:acc]
          split_at_duplicate_helper (x:[]) acc = [snoc x acc]
