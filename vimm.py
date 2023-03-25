#!/usr/bin/python3

import sys, string, os, subprocess
import re

#print(sys.argv)
#print(sys.argv[0])

help = "Usage: " + __file__ + " filename:line"

if len(sys.argv) < 2:
    print(help)
    sys.exit(0)

filename_line=sys.argv[1]
#print(filename_line)

first_blank=filename_line.find(' ')
if (-1 != first_blank):
    filename_line = filename_line[:first_blank]

if filename_line[-1] == ':':
    filename_line = filename_line[:-1]
    #filename_line[-1] = ' '
first_semicolon = filename_line.find(':')
#print(first_semicolon)
if (-1 != first_semicolon):
    filename = filename_line[:first_semicolon]
    line = filename_line[first_semicolon+1:]
    second_semicolon = line.find(':')
    if (-1 != second_semicolon):
        line = line[:second_semicolon]
    command = "vim " + filename + " +" + line
elif (filename_line[-1:].isdigit()):
    # filename_line has trailing line number
    lineno=re.search(r"(\d+)$", filename_line).group()
    #print(lineno)
    filename=filename_line[:-len(lineno)]
    command = "vim " + filename + " +" + lineno
else:
    command = "vim " + filename_line

#print(command)
subprocess.call(command, shell=True)
