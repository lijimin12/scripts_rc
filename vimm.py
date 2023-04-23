#!/usr/bin/python3
# use scenarios
# grep results: dir/name/basename:line: ...
# while default vim command line syntax is 'vim file +line'
# the intention is to click copy/paste the grep result and open vim to edit it, locating to the certain line
# the suggested location of this script is ~/bin
import sys, string, os, subprocess
import re

#print(sys.argv)
#print(sys.argv[0])

def usage():
    syntax = "Syntax: " + __file__ + " filename:line"
    print(syntax)
    formats = '''
    supported formats:
    filename line
    filename:line
    filename:line:
    filename+line
    filenameline
    '''
    print(formats)
    help = '''
    vv is an alias to vimm.py
    To view this usage help:
        vv
        vv --help or vv -h
    '''
    print(help)

if len(sys.argv) < 2:
    usage()
    sys.exit(0)

if len(sys.argv) == 3:
    # __file__ filename lineno
    filename = sys.argv[1]
    lineno = sys.argv[2]
    
    if (not lineno.isdigit()):
        print("{} should be line number".format(lineno))
        sys.exit(0)
    command = "vim " + filename + " +" + lineno
    #print(command)
    subprocess.call(command, shell=True)
    sys.exit(0)

if len(sys.argv) != 2:
    usage()
    sys.exit(0)

# hereafter, sys.argv == 2

if (sys.argv[1] == '--help' or sys.argv[1] == '-h'):
    usage()
    sys.exit(0)

filename_line=sys.argv[1]
#print(filename_line)

# trim stuff after blank space
first_blank=filename_line.find(' ')
if (-1 != first_blank):
    filename_line = filename_line[:first_blank]

# trim suffixing :
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
