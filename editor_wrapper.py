#!/usr/bin/python3
# use scenarios
# grep results: dir/name/basename:line: ...
# while default vim command line syntax is 'vim file +line'
# the intention is to click copy/paste the grep result and open vim to edit it, locating to the certain line
# the suggested location of this script is ~/bin
#
# 2023.8 从 vimm.py 扩展到 editor_wrapper.py，从而支持 vim, vscode, and notepad++ 
# windows ~/.bashrc
# alias np='"C:\Users\jiminli\AppData\Local\Programs\Python\Python38\python.exe" "C:\codes\Jimin-Z8\scripts\editor_wrapper.py" npp'
# alias vv='"C:\Users\jiminli\AppData\Local\Programs\Python\Python38\python.exe" "C:\codes\Jimin-Z8\scripts\editor_wrapper.py" vim'
# alias vs='"C:\Users\jiminli\AppData\Local\Programs\Python\Python38\python.exe" "C:\codes\Jimin-Z8\scripts\editor_wrapper.py" code'

import sys, string, os, subprocess
import re

#print(sys.argv)
#print(sys.argv[0])

def usage():
    syntax = "Syntax: " + __file__ + " vim|code|npp" + " filename:line"
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


def mk_cmd_str(editor, filename, lineno=""):
    if (editor == 'vim' or editor == "vi"):
        is_vim = 1
        command = "vim " + filename
        if (lineno != ""):
            command += " +" + lineno
    elif (editor == 'code'):
        is_vscode = 1
        # `code --goto file:line`
        command = "code --goto " + filename 
        if (lineno != ""):
            command += ":" + lineno
    elif (editor == 'npp'):
        is_npp = 1
        command = "/c/x/bin_tools/green/npp.7.8.bin.x64/notepad++.exe " + filename 
        if (lineno != ""):
            command += " -n" + lineno
    else:
        print("unknown editor")
        command = ""
    
    print(command)
    return command

if len(sys.argv) <= 2:
    usage()
    sys.exit(0)

if len(sys.argv) == 4:
    # CLI: __file__ vim|code|npp filename lineno
    editor = sys.argv[1]
    filename = sys.argv[2]
    lineno = sys.argv[3]
    
    if (not lineno.isdigit()):
        print("{} should be line number".format(lineno))
        sys.exit(0)

    command = mk_cmd_str(editor, filename, lineno)
    if (command == ""):
        usage()
        sys.exit(0)
    #print(command)
    subprocess.call(command, shell=True)
    sys.exit(0)

if len(sys.argv) != 3:
    usage()
    sys.exit(0)

# hereafter, sys.argv == 3
# CLI: __file__ vim|code|npp filename:lineno

if (sys.argv[1] == '--help' or sys.argv[1] == '-h'):
    usage()
    sys.exit(0)

editor = sys.argv[1]
filename_line=sys.argv[2]
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
    lineno = filename_line[first_semicolon+1:]
    second_semicolon = lineno.find(':')
    if (-1 != second_semicolon):
        lineno = lineno[:second_semicolon]

elif (filename_line[-1:].isdigit()):
    # filename_line has trailing line number
    lineno=re.search(r"(\d+)$", filename_line).group()
    #print(lineno)
    filename=filename_line[:-len(lineno)]

else:
    filename = filename_line    # no line number provided
    lineno = ""
    

command = mk_cmd_str(editor, filename, lineno)
print(command)
if (command == ""):
    usage()
    sys.exit(0)

subprocess.call(command, shell=True)
