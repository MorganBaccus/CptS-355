-- CptS 355 - Lab 1 (Haskell) - Spring 2022
-- Name: Morgan Baccus
-- Collaborated with: Lovee Baccus and Louis Kha. Both only a little

module Lab1
     where


-- 1.insert 
-- assume: n => 0

-- cases to consider
-- insert 0 10 [] --> [10]
-- insert 3 10 [] --> []
-- insert 0 10 [4,5,6,7,8] --> 10:4:[5,6,7,8]
-- insert 3 10 [4,5,6,7,8] --> 4:(insert (3-1) 10 [5,6,7,8] --> ... --> [4,5,6,10,7,8]

insert n a [] | (n==0) = [a]
              | otherwise = []
insert n a (x:xs) | (n==0) = a:(x:xs)
                  | otherwise = x:(insert (n-1) a xs)


-- 2. insertEvery
-- assume: n => 0

-- cases to consider:
-- insert 0 10 [] --> [10]
-- insert 3 10 [] --> []
-- insert 0 10 [4,5,6,7,8] --> insertHelper 0 10 (10:(4:[5,6,7,8])) (1)
-- insert 2 10 [4,5,6,7,8] --> 4:(insertHelper (2-1) 10 [5,6,7,8] --> ... --> [4,5,10,6,7,10,8]

insertEvery n a iL = insertHelper n a iL n
     where
          insertHelper n a [] on | (n>0) && (on>0) = []
                                 | otherwise = [a]
          insertHelper n a (x:xs) on | (on==0) = insertHelper n a (a:(x:xs)) (n+1)
                                     | otherwise = x:(insertHelper n a xs (on-1))


-- 3. getSales
mystorelog = [("Mon",50),("Fri",20), ("Tue",20),("Fri",10),("Wed",25),("Fri",30)]

getSales day [] = 0
getSales day ((d,sale):xs) | (d==day) = sale + (getSales day xs)
                           | otherwise = (getSales day xs)


-- 4. sumSales
mysales = [("Amazon",[("Mon",30),("Wed",100),("Sat",200)]),
 ("Etsy",[("Mon",50),("Tue",20),("Wed",25),("Fri",30)]),
 ("Ebay",[("Tue",60),("Wed",100),("Thu",30)]),
 ("Etsy",[("Tue",100),("Thu",50),("Sat",20),("Tue",10)])]

sumSales store day log = allsales store day log

allsales store day [] = 0
allsales store day ((s,log):xs) | (s==store) = (getSales day log) + (allsales store day xs)
                                | otherwise = (allsales store day xs)


-- 5. split
split c iL = splitHelper c iL []
  where
    splitHelper c [] [] = []
    splitHelper c [] acc = [reverse acc]
    splitHelper c (x:xs) acc = if c == x then (reverse acc) : splitHelper c xs [] else splitHelper c xs (x : acc)


-- 6. nSplit
nSplit c n iL = nSplitHelper c n iL []
  where
    nSplitHelper c 0 [] [] = []
    nSplitHelper c 0 iL [] = [iL]
    nSplitHelper c n [] [] = []
    nSplitHelper c n [] acc = [reverse acc]
    nSplitHelper c n (x:xs) acc = if c == x then (reverse acc) : nSplitHelper c (n - 1) xs [] else nSplitHelper c n xs (x : acc)
