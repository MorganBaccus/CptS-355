# CptS 355 - Spring 2022 - Assignment 3 - Python

# Please include your name and the names of the students with whom you discussed any of the problems in this homework
# Name: Morgan Baccus
# Collaborators: 

wsu_games = {
2018: { "WYO":(41,19), "SJSU":(31,0), "EWU":(59,24), "USC":(36,39), "UTAH":(28,24), 
"ORST":(56,37), "ORE":(34,20), "STAN":(41,38), "CAL":(19,13), "COLO":(31,7), 
"ARIZ":(69,28), "WASH":(15,28), "ISU":(28,26)},
2019: {"NMSU":(58,7), "UNCO":(59,17), "HOU":(31,24), "UCLA":(63,67), "UTAH":(13,38), 
"ASU":(34,38), "COLO":(41,10), "ORE":(35,37), "CAL":(20,33), "STAN":(49,22), 
"ORST":(54,53), "WASH":(13,31), "AFA":(21,31) },
2020: {"ORST":(38,28), "ORE":(29,43), "USC":(13,38), "UTAH":(28,45)},
2021: { "USU":(23,26), "PORT ST.":(44,24), "USC":(14,45), "UTAH":(13,24), "CAL":(21,6),
"ORST":(31,24), "STAN":(34,31), "BYU":(19,21), "ASU":(34,21), "ORE":(24,38), 
"ARIZ":(44,18), "WASH":(40,13), "CMU":(21,24)} }

debugging = False
def debug(*s): 
     if debugging: 
          print(*s)

## problem 1 - all_games - 8%
def all_games(data):
     mylog = {}
     for year,log in data.items():
          for team,number in log.items():
               if team not in mylog.keys():
                    mylog[team] = {}
               mylog[team][year] = number
     return mylog

## problem 2 - common_teams - 15%
def common_teams(data):
     comp_dict = {2018:(0,0), 2019:(0,0), 2020:(0,0), 2021:(0,0)}
     allgames = {}
     allgames = all_games(data)
     commonteams = {}
     for team,log in allgames.items():
          if  log.keys() == comp_dict.keys():
               commonteams[team] = log
     
     commonteams_final = {}
     for team,log in commonteams.items():
          for year,number in log.items():
               commonteams_final[team] = list(log.values())

     return commonteams_final

## problem 3 - get_wins - 16%
from functools import reduce
def get_win_helper(elem):
     (temp, (score1, score2)) = elem
     if score1 > score2:
          return True
     else:
          return False

def get_wins(data, team):
     wins = list(filter(get_win_helper, map(lambda year: (year,data[year][team] if team in data[year] else (-1,0)), data.keys())))
     return wins

## problem 4 - wins_by_year - 16%
def wins_by_year(data):
    data_list = list(data.items())
    helper1_map = list(map(helper1, data_list))
    helper2_map = list(map(helper2, data_list, helper1_map))
    return helper2_map
    
def helper1(data):
    get_wins = lambda tup: True if tup[0] > tup[1] else False
    values_list = list(data[1].values())
    filtered_list = list(filter(lambda x: get_wins(x), values_list))
    return filtered_list

def helper2(year, win):
    return (year[0], len(win))

## problem 5 - longest_path - 16% 
def longest_path(graph, node):
    visited = []
    path_length = len(helper(graph, node, visited))
    return path_length

def helper(graph, start, visited):
    visited = visited + [start]
    now_visited = visited
    for node in list(graph[start]):
        if node not in visited:
            new_path = helper(graph, node, visited)
            if(len(new_path) > len(now_visited)):
                now_visited = new_path

    return now_visited

## problem 6 - counter - 20% 
import collections
class counter:
     def __init__(self, data):
          self.data = data
          os = ""
          for c in self.data:
               if c != " " or (os and os[-1] != " "):
                    os += c 
          self.data = os.strip('\n')
          self.data = self.data.replace('\n',"")
          self.data = self.data.replace("  "," ")
          if self.data[0] == ' ':
               self.data = self.data[1:]
          
          self.words = collections.defaultdict(int)

     def __next__(self):
          idx = self.data.find(' ')

          if len(self.data) == 0:
               raise StopIteration
          if idx == -1:
               result = self.data
               self.data = ""
               self.words[result] += 1
               return (result, self.words[result])
          
          nextWord = self.data[0:idx]
          self.words[nextWord] += 1
          self.data = self.data[idx+1:].lower()
          return (nextWord, self.words[nextWord])

     def __iter__(self):
          return self

numbers = """ 
     Skip 
     Skip Erin 
     Skip Erin Austin  
     Skip Erin Austin Morgan 
     Skip Erin Austin Morgan Lovee
     Skip Erin Austin Morgan Lovee Scout
"""
rest = []
mywords = counter(numbers)
mywords.__next__() # skip over first 2 words
mywords.__next__() 
for word in mywords: 
     rest.append(word)

print(rest)