#------------------------------------------------------
#-- INCLUDE YOUR OWN TESTS IN THIS FILE
#------------------------------------------------------
import unittest
from HW3 import *

class HW3SampleTests(unittest.TestCase):
    "Unittest setup file. Unittest framework will run this before every test."
    def setUp(self):
        self.nba_games = {
            2018: { "HEAT":(80,28), "BUCKS":(99,10),  "76ERS":(109,64), "CELTICS":(36,59), "BULLS":(68,64), 
                   "LAKERS":(156,137), "WARRIORS":(134,120), "NETS":(131, 128), "CAVALIERS":(109, 103), "RAPTORS":(121, 97), 
                   "SPURS":(159, 188), "ROCKETS":(115,128), "THUNDER":(138, 136)},
            2019: {"HORNETS":(158, 117), "CLIPPERS":(159, 117), "TIMBERWOLVES":(131, 124), "KINGS":(163, 167), "BULLS":(73,78), 
                    "HAWKS":(134, 138), "RAPTORS":(131, 110), "WARRIORS":(135,137), "CAVALIERS":(120,133), "NETS":(129, 102), 
                   "LAKERS":(84,83), "ROCKETS":(113,131), "JAZZ":(121, 131) },
            2020: {"LAKERS":(98,88), "WARRIORS":(129,143), "CELTICS":(113,138), "BULLS":(128,145)},
            2021: { "WIZARDS":(123, 126), "PACERS.":(144, 124), "CELTICS":(119,151), "BULLS":(53,64), "CAVALIERS":(121, 96),
                   "LAKERS":(121,114), "NETS":(124, 121), "PISTONS":(119, 121), "HAWKS":(134, 121), "WARRIORS":(124,138), 
                   "SPURS":(154, 128), "ROCKETS":(140,113), "MAVERICKS":(121, 124)} }

        self.graph = {
            'AUSTIN':{'MORGAN','LOVEE','SCOUT'},
            'MORGAN':{'LOVEE'},
            'LOVEE':{'MORGAN','ERIN','FLAPJACK','SKIP'},
            'SCOUT':{'AUSTIN','ERIN','FLAPJACK'},
            'ERIN':{'FLAPJACK'},
            'FLAPJACK':{'ERIN', 'SKIP'},
            'SKIP':{}, 
            'FUDGE':{'FLAPJACK','SKIP'} }

        self.numbers = """ 
            Skip 
            Skip Erin 
            Skip Erin Austin  
            Skip Erin Austin Morgan 
            Skip Erin Austin Morgan Lovee
            Skip Erin Austin Morgan Lovee Scout
        """

    #--- Problem 1----------------------------------
    def test_all_games(self):
        output = {'HEAT': {2018: (80, 28)}, 
                'BUCKS': {2018: (99, 10)}, 
                '76ERS': {2018: (109,64)}, 
                'CELTICS': {2018: (36, 59), 2020: (113, 138), 2021: (119, 151)}, 
                'BULLS': {2018: (68,64), 2019: (73,78), 2020: (128, 145), 2021: (53,64)}, 
                'LAKERS': {2018: (156,137), 2019: (84,83), 2020: (98,88), 2021: (121,114)}, 
                'WARRIORS': {2018: (134,120), 2019: (135, 137), 2020: (129, 143), 2021: (124, 138)}, 
                'NETS': {2018: (131, 128), 2019: (129, 102), 2021: (124, 121)}, 
                'CAVALIERS': {2018: (109, 103), 2019: (120, 133), 2021: (121, 96)}, 
                'RAPTORS': {2018: (121, 97), 2019: (131, 110)}, 
                'SPURS': {2018: (159, 188), 2021: (154, 128)}, 
                'ROCKETS': {2018: (115, 128), 2019: (113, 131), 2021: (140, 113)}, 
                'THUNDER': {2018: (138, 136)}, 
                'HORNETS': {2019: (158, 117)}, 
                'CLIPPERS': {2019: (159, 117)}, 
                'TIMBERWOLVES': {2019: (131, 124)}, 
                'KINGS': {2019: (163, 167)}, 
                'HAWKS': {2019: (134, 138), 2021: (134, 121)}, 
                'JAZZ': {2019: (121, 131)}, 
                'WIZARDS': {2021: (123, 126)}, 
                'PACERS.': {2021: (144, 124)}, 
                'PISTONS': {2021: (119, 121)}, 
                'MAVERICKS': {2021: (121, 124)} }

        self.assertDictEqual(all_games(self.nba_games),output)
    
    #--- Problem 2----------------------------------
    def test_common_teams(self):
        output = {'BULLS': [(68,64), (73,78), (128, 145), (53,64)], 'LAKERS': [(156,137), (84,83), (98,88), (121,114)], 'WARRIORS': [(134,120), (135, 137), (129, 143), (124, 138)]}
        self.assertDictEqual(common_teams(self.nba_games),output)

    #--- Problem 3 ----------------------------------
    def test_get_wins(self):
        output1 = [(2018, (68,64))]
        self.assertListEqual(get_wins(self.nba_games,'BULLS'),output1 )
        output2 = [(2018, (131, 128)), (2019, (129, 102)), (2021, (124, 121))]
        self.assertListEqual(get_wins(self.nba_games,'NETS'),output2 )

    #--- Problem 4----------------------------------
    def test_wins_by_year(self):
       output = [(2018, 10), (2019, 6), (2020, 1), (2021, 7)]
       self.assertListEqual(wins_by_year(self.nba_games),output )
    
    #--- Problem 5 ----------------------------------
    def test_1_longest_path(self):
        self.assertEqual(longest_path(self.graph,'AUSTIN'),6)
    
    def test_2_longest_path(self):
        self.assertEqual(longest_path(self.graph,'SCOUT'),7)
        
    def test_3_longest_path(self):
        self.assertEqual(longest_path(self.graph,'LOVEE'),4)

    def test_4_longest_path(self):
        self.assertEqual(longest_path(self.graph,'FLAPJACK'),2)

    #--- Problem 6----------------------------------
    def test_counter(self):
        self.tokens = [('erin', 1), ('skip', 2), ('erin', 2), ('austin', 1), ('skip', 3), ('erin', 3), ('austin', 2), ('morgan', 1), ('skip', 4), ('erin', 4), ('austin', 3), ('morgan', 2), ('lovee', 1), ('skip', 5), ('erin', 5), ('austin', 4), ('morgan', 3), ('lovee', 2), ('scout', 1)]
        mywords = counter(self.numbers)
        mywords.__next__()   # skip first tuple ('one',1)
        mywords.__next__()   # skip second tuple ('one',2)
        
        rest = []
        for word in mywords:  
            rest.append(word)
        self.assertListEqual(rest,self.tokens)
    
if __name__ == '__main__':
    unittest.main()

