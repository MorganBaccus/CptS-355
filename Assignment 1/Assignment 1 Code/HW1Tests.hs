{- Example of using the HUnit unit test framework.  See  http://hackage.haskell.org/package/HUnit for additional documentation.
To run the tests type "run" at the Haskell prompt.  -} 

module HW1Tests
    where

import Test.HUnit
import Data.Char
import Data.List (sort)
import HW1

-- P1. list_diff tests
p1_test4 = TestCase (assertEqual "list_diff-test4" 
                                 (sort [2,6,10,14,16,20,24,28])
                                 (sort $ list_diff [2,4,6,8,10,12,14] [4,8,12,16,20,24,28]) )
p1_test5 = TestCase (assertEqual "list_diff-test5" 
                                 []  
                                 (list_diff ["morgan","austin","lovee","skip","erin","scout"]  ["skip", "erin","austin","morgan","lovee","scout"]) )

-- P2. replace tests
p2_test4 = TestCase (assertEqual "replace-test4" 
                                  "I have CptS 427 at 2:20pm MWF"
                                  (replace "I have CptS 437 at 2:30pm MWF" '3' '2' 2) ) 
p2_test5 = TestCase (assertEqual "replace-test5" 
                                  [(1,2),(7,7),(7,7),(5,6),(2,3)] 
                                  (replace [(1,2),(3,4),(3,4),(5,6),(2,3)] (3,4) (7,7) 2) ) 
p2_test6 = TestCase (assertEqual "replace-test6" 
                                  [100,2,3,4,100,2,3,4,100,2,3,4,100,2,3,4]  
                                  (replace [1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4] 1 100 5) )

-- P3. max_date tests                                  
p3_test4 = TestCase (assertEqual "max_date-test4" 
                                  (2,1,2022)
                                  (max_date [(2,1,2015),(2,1,2016),(2,1,2017),(2,1,2018),(2,1,2019),(2,1,2020),(2,1,2021),(2,1,2022)]) ) 
p3_test5 = TestCase (assertEqual "max_date-test5" 
                                  (12,26,2022)   
                                  (max_date [(11, 26, 2022),(10, 26, 2022), (9, 26, 2022),(8, 26, 2022), (7, 26, 2022),(12, 26, 2022)]) ) 
p3_test6 = TestCase (assertEqual "max_date-test6" 
                                  (1,1,2022)  
                                  (max_date [(1, 1, 2022)]) ) 

-- P4. num_paths tests                                  
p4_test5 = TestCase (assertEqual "num_paths-test5" 
                                  2  
                                  (num_paths 2 2) ) 
p4_test6 = TestCase (assertEqual "num_paths-test6" 
                                  1 
                                  (num_paths 10 1) ) 
p4_test7 = TestCase (assertEqual "num_paths-test7" 
                                  6 
                                  (num_paths 3 3) ) 
                                                           
-- P5. (a) and (b)
-- find_courses tests
faveFoods =
     [ ("Morgan" , ["Cheese","Apples","Coffee","Chicken"]),
     ("Austin" , ["Taquitos","Sandwiches"]),
     ("Lovee" , ["Cheese","Apples","Coffee","Chicken","Pickles"]),
     ("Skip" , ["Coffee","Chicken","Sandwiches"]),
     ("Erin" , ["Apples, Coffee","Pickles","Toast"]),
     ("Scout" , ["Cheese","Apples","Chicken"])
     ]
                                
p5a_test4 = TestCase (assertEqual "(find_courses-test4)" 
                                  ["Morgan","Lovee","Scout"] 
                                  (find_courses faveFoods "Cheese") ) 
p5a_test5 = TestCase (assertEqual "(find_courses-test5)" 
                                  ["Erin"]
                                  (find_courses faveFoods "Toast") )                             
p5a_test6 = TestCase (assertEqual "(find_courses-test6)" 
                                  []
                                  (find_courses faveFoods "Pasta") )                           

-- max_count tests  (one test is sufficient)
p5b_test2 = TestCase (assertEqual "(max_count-test2)" 
                                   ("Lovee",5)
                                   (max_count faveFoods) ) 


-- split_at_duplicate tests
p6_test5 = TestCase (assertEqual "(split_at_duplicate-test5)"  
                                 [[1],[1,5,7,3],[3,5,9,3,2],[2,8]] 
                                 (split_at_duplicate [1,1,5,7,3,3,5,9,3,2,2,8] ) )
p6_test6 = TestCase (assertEqual "(split_at_duplicate-test6)" 
                                 [[7],[7]]  
                                 (split_at_duplicate [7,7]) ) 
p6_test7 = TestCase (assertEqual "(split_at_duplicate-test7)"  
                                 [[2,4,6,8,10,12,14,16]] 
                                 (split_at_duplicate [2,4,6,8,10,12,14,16] ) )


-- add the test cases you created to the below list. 
tests = TestList [ TestLabel "Problem 1- test4 " p1_test4,
                   TestLabel "Problem 1- test5 " p1_test5,  
                   TestLabel "Problem 2- test4 " p2_test4,
                   TestLabel "Problem 2- test5 " p2_test5,  
                   TestLabel "Problem 2- test6 " p2_test6,
                   TestLabel "Problem 3- test4 " p3_test4, 
                   TestLabel "Problem 3- test5 " p3_test5, 
                   TestLabel "Problem 3- test6 " p3_test6,
                   TestLabel "Problem 4- test5 " p4_test5, 
                   TestLabel "Problem 4- test6 " p4_test6,
                   TestLabel "Problem 4- test7 " p4_test7,
                   TestLabel "Problem 5a- test4 " p5a_test4, 
                   TestLabel "Problem 5a- test5 " p5a_test5,
                   TestLabel "Problem 5a- test6 " p5a_test6, 
                   TestLabel "Problem 5b- test2 " p5b_test2,
                   TestLabel "Problem 6- test5 " p6_test5, 
                   TestLabel "Problem 6- test6 " p6_test6,
                   TestLabel "Problem 6- test7 " p6_test7
                 ] 
                  
-- shortcut to run the tests
run = runTestTT  tests