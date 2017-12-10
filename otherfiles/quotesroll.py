#! /usr/local/bin/python
import random
import sys

lines = [line for line in
        open('/Users/{}/Dropbox/codes/notes/planning/quotes-roll'.format(sys.argv[1]))]

print lines[random.randint(0, len(lines)-1)].strip()
