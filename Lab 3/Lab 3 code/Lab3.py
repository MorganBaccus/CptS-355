# CptS 355 - Spring 2022 - Lab 3
# Name: Morgan Baccus

debugging = False
def debug(*s): 
     if debugging: 
          print(*s)

## problem 1 getNumCases 
def getNumCases(data,counties,months):
    total = 0
    for county in counties:
        for month in months:
            total += data.get(county,{}).get(month,0)
    return total

## problem 2 getMonthlyCases
def getMonthlyCases(data):
    mylog = {}
    for county,log in data.items():
        for month,number in log.items():
            if month not in mylog.keys():
                mylog[month] = {}
            mylog[month][county] = number
    return mylog

## problem 3 mostCases 
from functools import reduce
def mostCases(data):
    sum_log = lambda log : reduce(lambda x,y: x+y, log.values())
    map_helper = lambda t: (t[0], sum_log(t[1]))
    max_tuple = lambda t1,t2: t1 if t1[1] > t2[1] else t2

    monthlyCases = getMonthlyCases(data)
    map_result = map(map_helper , monthlyCases.items())
    return reduce(max_tuple,map_result)

## problem 4a) searchDicts(L,k)
def searchDicts(L,k): 
    for d in reversed(L):
        dKey = list(d.keys())
        #check if k is one of the keys in the dictionary, if yes return and break
        if (dKey[0] == k or d.get(k)):
            return d.get(k)
    return None

## problem 4b) searchDicts2(L,k)
def searchDicts2_helper(tL,k,ind): 
    if k in tL[ind][1]:
        return tL[ind][1][k]
    else:
        if ind == 0:
            return None
        else:
            next_ind = tL[ind][0]
            return searchDicts2_helper(tL,k,next_ind)

def searchDicts2(tL,k):
    return searchDicts2_helper(tL,k,len(tL)-1)

## problem 5 - getLongest
def getLongest(L):
    get_longer = lambda x,y: x if len(x) > len(y) else y
    longest = ''
    for item in L:
        # if item is a list make recursive call on that item and then compare the
        # value that the recursive call returns with the current longest,
        if type(item) == list:
            longest = get_longer(getLongest(item), longest)
        # else compare with the current longest, and update current longest if needed.
        else:
            longest = get_longer(item, longest)
    return longest

## problem 6 - apply2nextN
class apply2nextN(object):
    def __init__(self,f,n,it):
        self.input = it
        self.n = n
        self.op = f
        self.current = self.get_next()
    
    def get_next(self):
        try:
            current = self.input.__next__()
        except:
            current = None
        return current

    def __next__(self):
        if self.current is None:
            raise StopIteration
        local_n = self.n
        total = self.current
        while local_n > 1:
            self.current = self.get_next()
            if self.current is None:
                return total
            total = self.op(total,self.current)
            local_n -= 1
        return total

    def __iter__(self):
        return self