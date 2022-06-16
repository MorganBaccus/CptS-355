{- Example of using the HUnit unit test framework.  See  http://hackage.haskell.org/package/HUnit for additional documentation.
To run the tests type "run" at the Haskell prompt.  -} 

module HW2Tests
    where

import Test.HUnit
import Data.Char
import Data.List (sort)
import HW2

------------------------------------------------------
-- INCLUDE YOUR TREE EXAMPLES HERE
tree1 = NODE 2 (NODE 4 (NODE 6 (LEAF 8) (LEAF 10)) (LEAF 12)) (NODE 14 (LEAF 16) (LEAF 18))
tree2 = NODE 1 (NODE 3 (LEAF 5) (LEAF 7)) (NODE 9 (NODE 11 (LEAF 13)  (LEAF 15))  (LEAF 17))

tree3 = NODE 4 (NODE 22 (NODE 11 (LEAF 7) (LEAF 72)) (LEAF 67)) (NODE 53 (LEAF 12) (LEAF 99))
tree4  = NODE 88 (NODE 22 (NODE 33 (LEAF 22) (LEAF 55)) (LEAF 11)) (NODE 11 (LEAF 88) (LEAF 55))

tree5 =  NODE 
         "Marie" 
         (NODE "my" (LEAF "Hello,")(NODE 
                                      "is" 
                                      (LEAF "name") 
                                      (LEAF "Morgan"))) 
          (LEAF "Baccus")

------------------------------------------------------

-- P1 - commons, commons_tail, and commons_all 
-- (a) commons tests
p1a_test1 = TestCase (assertEqual "commons test-1" 
                                   (sort [2,4,6,8])  
                                   (sort (commons [1,2,3,4,5,6,7,8,9] [2,4,6,8,10,12,14,16,18])) ) 
p1a_test2 = TestCase (assertEqual "commons test-2" 
                                    (sort ["a"])  
                                    (sort (commons ["m","o","r","g","a","n"] ["b","a","c","c","u","s"])) ) 
-- (b) commons_tail tests
p1b_test1 = TestCase (assertEqual "commons test-1" 
                                   (sort [2,4,6,8])  
                                   (sort (commons [1,2,3,4,5,6,7,8,9] [2,4,6,8,10,12,14,16,18])) ) 
p1b_test2 = TestCase (assertEqual "commons test-2" 
                                    (sort ["a"])  
                                    (sort (commons ["m","o","r","g","a","n"] ["b","a","c","c","u","s"])) ) 
-- (c) commons_all tests
p1c_test1 = TestCase (assertEqual "commons_all test-1" 
                                    (sort ["a"])  
                                    (sort (commons_all [["m","o","r","g","a","n"], ["m","a","r","i","e"], ["b","a","c","c","u","s"]])) )
p1c_test2 = TestCase (assertEqual "commons_all test-2" 
                                    (sort [2]) 
                                    (sort (commons_all [[1,2,3],[2,4,6],[-2,0,2]])) )
------------------------------------------------------
-- P2  find_courses and max_count
faveFoods =
     [ ("Morgan", ["Cheese","Apples","Coffee","Chicken"]),
       ("Austin", ["Taquitos","Sandwiches"]),
       ("Lovee",  ["Cheese","Apples","Coffee","Chicken","Pickles"]),
       ("Skip",   ["Coffee","Chicken","Sandwiches"]),
       ("Erin",   ["Apples", "Coffee","Pickles","Toast"]),
       ("Scout",  ["Cheese","Apples","Chicken"])
     ]
-- (a) find_languages tests
p2a_test1 = TestCase (assertEqual "find_languages test-1" 
                                    (["Cheese","Apples","Chicken"])  
                                    (find_languages faveFoods ["Morgan", "Lovee", "Scout"]) )
p2a_test2 = TestCase (assertEqual "find_languages test-2" 
                                    (["Sandwiches"])  
                                    (find_languages faveFoods ["Skip", "Austin"]) )
-- (b) find_courses tests
p2b_test1 = TestCase (assertEqual "find_courses test-1" 
                                    ([("Chicken",["Morgan","Lovee","Skip","Scout"]),("Cheese",["Morgan","Lovee","Scout"]),("Apples",["Morgan","Lovee","Erin","Scout"])])  
                                    (find_courses faveFoods ["Chicken","Cheese","Apples"]) )
p2b_test2 = TestCase (assertEqual "find_courses test-2" 
                                    ([("Taquitos",["Austin"]),("Sandwiches",["Austin","Skip"])])  
                                    (find_courses faveFoods ["Taquitos","Sandwiches"]) )
------------------------------------------------------
-- P3  nested_max, max_maybe, and max_numbers
-- (a) nested_max tests
p3a_test1 = TestCase (assertEqual "nested_max test-1" 
                                    13 
                                    (nested_max [[1,2,3],[4,5],[6,7,8,9],[10,11,12,13]]) ) 
p3a_test2 = TestCase (assertEqual "nested_max test-2" 
                                    5
                                    (nested_max [[2,4],[1,3,5],[1,2,3,4,5]]) ) 
-- (b) max_maybe tests
p3b_test1 = TestCase (assertEqual "max_maybe test-1" 
                                   (Just 8) 
                                   (max_maybe [[(Just 1),(Just 2),(Just 3),(Just 4)],[(Just 5),(Just 6)],[(Just 7),(Just 8),Nothing ],[],[Nothing ]]) )
p3b_test2 = TestCase (assertEqual "max_maybe test-2" 
                                   (Just "R") 
                                   (max_maybe [[(Just "M"),Nothing],[(Just "O"), (Just "R"), (Just "G"),Nothing,Nothing]]) )
-- (c) max_numbers tests
p3c_test1 = TestCase (assertEqual "max_numbers test-1" 
                                    (8) 
                                    (max_numbers [[StrNumber "1",IntNumber 2,IntNumber 3],[StrNumber "4",StrNumber "5"],[IntNumber 6,IntNumber 7],[StrNumber "8"]]) )
p3c_test2 = TestCase (assertEqual "max_numbers test-2" 
                                    (25) 
                                    (max_numbers [[StrNumber "2" , IntNumber 4],[StrNumber "6"],[IntNumber 25]]) )
------------------------------------------------------
-- P4  tree_scan, tree_search, merge_trees
-- (a) tree_scan tests
p4a_test1 = TestCase (assertEqual "tree_scan test-1"  
                                   ["Hello,","my","name","is","Morgan","Marie","Baccus"] 
                                   (tree_scan tree5) ) 
p4a_test2 = TestCase (assertEqual "tree_scan test-2" 
                                   [7,11,72,22,67,4,12,53,99] 
                                   (tree_scan tree3) ) 
-- (b) tree_search tests
p4b_test1 = TestCase (assertEqual "tree_search test-1" 
                                   3 
                                   (tree_search tree4 11) ) 
p4b_test2 = TestCase (assertEqual "tree_search test-2" 
                                   1 
                                   (tree_search tree4 88) )
p4b_test3 = TestCase (assertEqual "tree_search test-3" 
                                   (-1) 
                                   (tree_search tree4 44) )
-- (c) merge_trees  tests
addedTree = NODE 3 (NODE 7 (NODE 11 (LEAF 8) (LEAF 10)) (LEAF 19)) (NODE 23 (NODE 27 (LEAF 13) (LEAF 15)) (LEAF 35))
p4c_test1 = TestCase (assertEqual "merge_trees test-1" 
                                   addedTree  
                                   (merge_trees tree1 tree2) ) 
------------------------------------------------------

-- add the test cases you created to the below list. 
tests = TestList [ TestLabel "Problem 1a - test1 " p1a_test1,
                   TestLabel "Problem 1a - test2 " p1a_test2,                  
                   TestLabel "Problem 1b - test1 " p1b_test1,
                   TestLabel "Problem 1b - test2 " p1b_test2,                                                      
                   TestLabel "Problem 1c - test1 " p1c_test1,
                   TestLabel "Problem 1c - test2 " p1c_test2,
                   TestLabel "Problem 2a - test1 " p2a_test1,
                   TestLabel "Problem 2a - test2 " p2a_test2,  
                   TestLabel "Problem 2b - test1 " p2b_test1,
                   TestLabel "Problem 2b - test2 " p2b_test2,
                   TestLabel "Problem 3a - test1 " p3a_test1,
                   TestLabel "Problem 3a - test2 " p3a_test2,                     
                   TestLabel "Problem 3b - test1 " p3b_test1,
                   TestLabel "Problem 3b - test2 " p3b_test2,
                   TestLabel "Problem 3c - test1 " p3c_test1,
                   TestLabel "Problem 3c - test2 " p3c_test2,
                   TestLabel "Problem 4a - test1 " p4a_test1,
                   TestLabel "Problem 4a - test2 " p4a_test2,
                   TestLabel "Problem 4b - test1 " p4b_test1,
                   TestLabel "Problem 4b - test2 " p4b_test2,
                   TestLabel "Problem 4b - test3 " p4b_test3,
                   TestLabel "Problem 4c - test1 " p4c_test1
                 ] 
                  
-- shortcut to run the tests
run = runTestTT  tests