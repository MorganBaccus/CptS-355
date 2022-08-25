-- CptS 355 - Lab 2 (Haskell) - Spring 2022
-- Name: Morgan Baccus
-- Collaborated with: 

module Lab2
     where


-- 1
{- (a) merge2 -}
merge2 :: [a] -> [a] -> [a]
merge2 list1 [] = list1
merge2 [] list2 = list2
merge2 (x:xs) (y:ys) = x:y:merge2 xs ys
                         

{- (b) merge2Tail -}
merge2Tail :: [a] -> [a] -> [a]
merge2Tail list1 list2 = helper list1 list2 []
     where
          helper list1 [] acc = (reverse acc) ++ list1
          helper [] list2 acc = (reverse acc) ++ list2
          helper (x:xs) (y:ys) acc = helper xs ys (y:x:acc)


{- (c) mergeN -}
mergeN:: [[a]] -> [a]
mergeN [[]] = []
mergeN list = foldl merge2 [] list


-- 2
{- (a) count -}
count :: Eq a => a -> [a] -> Int
count a [] = 0
count a list = length (filter (\x-> (x==a)) list)


{- (b) histogram  -}
eliminateDuplicates:: Eq a => [a] -> [a]
eliminateDuplicates [] = []
eliminateDuplicates (x:xs) | elem x xs = eliminateDuplicates xs
                           | otherwise = x:(eliminateDuplicates xs)

countElem list = map (\x-> count x list) list
getSqTuples list = map(\x-> (x, x*x)) list

histogram :: Eq a => [a] -> [(a, Int)]
histogram list = eliminateDuplicates (zip list (countElem list))


-- 3                
{- (a) concatAll -}
concatAll :: [[String]] -> String
concatAll list = concatL (map concatL list)
     where
          concatL xs = foldr (++) "" xs


{- (b) concat2Either -}               
data AnEither  = AString String | AnInt Int
                deriving (Show, Read, Eq)

concat2Either:: [[AnEither]] -> AnEither
concat2Either list = eitherConcat (map eitherConcat list)
      where
          eitherConcat xs = AString (foldr (\d ds -> stringify d ++ ds) [] xs)
          stringify (AString a) = a
          stringify (AnInt a) = show a


-- 4      
{-  concat2Str -}               
concat2Str :: [[AnEither]] -> String
concat2Str list = foldr (++) [] (map concatL list)
    where
        concatL xs = foldr (\d ds -> stringify d ++ ds) [] xs
        stringify (AString a) = a
        stringify (AnInt a) = show a

data Op = Add | Sub | Mul | Pow
          deriving (Show, Read, Eq)

evaluate:: Op -> Int -> Int -> Int
evaluate Add x y =  x+y
evaluate Sub   x y =  x-y
evaluate Mul x y =  x*y
evaluate Pow x y = x^y

data ExprTree a = ELEAF a | ENODE Op (ExprTree a) (ExprTree a)
                  deriving (Show, Read, Eq)

-- 5 
{- evaluateTree -}
evaluateTree :: ExprTree Int -> Int
evaluateTree (ENODE op b c) = evaluate op (evaluateTree b) (evaluateTree c)
evaluateTree (ELEAF a) = a


-- 6
{- printInfix -}



--7
{- createRTree -}
data ResultTree a  = RLEAF a | RNODE a (ResultTree a) (ResultTree a)
                     deriving (Show, Read, Eq)






