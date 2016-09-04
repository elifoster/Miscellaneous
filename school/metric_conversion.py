from time import sleep
from sys import exit

l=0
v=1
m=2
q=3

def wait(seconds):
    sleep(seconds)

def length():
    base = float(input("What is the base unit?\n"))
    print("What conversion?\n")
    conversion = input("Enter: 0 for meter -> kilometer, 1 for meter -> centimeter, or 2 for meter -> millimeter\n")

    if conversion == 0:
        print (str(base * 1000 + "km"))

    if conversion == 1:
        print (str(base * 0.01 + "cm"))

    if conversion == 2:
        print (str(base * 0.001 + "mm"))

    print ("Done")
    main()

def volume():
    base = float(input("What is the base unit?\n"))
    print("What conversion?\n")
    conversion = input("Enter: 0 for liter -> kiloliter, 1 for liter -> centiliter, or 2 for liter -> milliliter\n")

    if conversion == 0:
        print (base * 1000 + "kL")

    if conversion == 1:
        print (str(base * 0.01 + "cL"))

    if conversion == 2:
        print (str(base * 0.001 + "mL"))

    print ("Done")
    main()

def mass():
    base = float(input("What is the base unit?\n"))
    print("What conversion?\n")
    conversion = input("Enter: 0 for gram -> kilogram, 1 for gram -> centigram, or 2 for gram -> milligram\n")

    if conversion == 0:
        print (str(base * 1000 + "kg"))

    if conversion == 1:
        print (str(base * 0.01 + "cg"))

    if conversion == 2:
        print (str(base * 0.001 + "mg"))

    print ("Done")
    main()

def main():
    print("What property would you like to convert?\n")
    question = int(input("Enter: 0 for length, 1 for volume, 2 for mass, 3 to quit\n"))
    if question==l:
        length()
    if question==v:
        volume()
    if question==m:
        mass()
    if question==q:
        exit()

print("Welcome to the Metric Conversion Calculator.\n This program will convert a base unit (gram, liter, or meter).")
main()
