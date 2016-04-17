#! /usr/local/bin/python
import random
lines = [line for line in open('/Users/apple/Dropbox/codes/notes/planning/quotes-roll')]

print lines[random.randint(0, len(lines)-1)]
