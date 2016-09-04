import random
import time
import sys
import gc

def loop():
    lo = input("Would you like to roll again? (0 for yes, 1 for no)\n")
    while True:
        if lo == str(0):
            run()
        elif lo == str(1):
            print("Done")
            sys.exit()

def run():
    number = input("How many sides would you like your dice to have? ")
    try:
        if int(number) < 3:
            print("A die must have 3 or more sides.")
            number = None
            run()
        else:
            print("Rolling...")
            new_number = random.uniform(1, int(number))
            print(int(new_number))
            number = None
            new_number = None
            loop()
    except ValueError:
        print("That is not an integer!")
        number = None
        run()

run()

