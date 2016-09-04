from sys import exit
from time import sleep

x=0
y=1

print("Welcome to the Percent Error calculator\n")

def calculate():
    exp = float(input("Please input the experimental value and press enter\n"))
    if type(exp) == float:
        the = float(input("Please input the theoretical value and press enter\n"))
        
	res1 = (exp - the)
        res2 = (res1/the)
        res3 = (res2*100)
        print("Percent error: " + str(res3))
    elif type(exp) == int:
        print("Floating decimals only! No integers!\n")
        return
    elif type(exp) == str:
        print("Floating decimals only! No strings!\n")
        return

    return

def perform():
    calculate()
    question()
    return

def question():
    q = input("To quit, type 0, if not, type 1\n")
    if q==x:
        exit()
    if q==y:
        perform()
    return

perform()
