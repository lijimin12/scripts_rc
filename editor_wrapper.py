#!/c/Users/jiminli/AppData/Local/Programs/Python/Python38/python
#!/usr/bin/python3
# use scenarios 动机
# grep results: dir/name/basename:line:text containing matched pattern
# while default vim command line syntax is 'vim file +line'
# the intention is to click copy/paste the grep result and open vim to edit it, locating to the certain line
# the suggested location of this script is ~/bin
#
# NOTE: just support only one filename as script arugments
#
# 2023.8 从 vimm.py 扩展到 editor_wrapper.py，从而支持 vim, vscode, and notepad++ 
# windows ~/.bashrc
# alias np='"C:\Users\jiminli\AppData\Local\Programs\Python\Python38\python.exe" "C:\codes\Jimin-Z8\scripts\editor_wrapper.py" npp'
# alias vv='"C:\Users\jiminli\AppData\Local\Programs\Python\Python38\python.exe" "C:\codes\Jimin-Z8\scripts\editor_wrapper.py" vim'
# alias vs='"C:\Users\jiminli\AppData\Local\Programs\Python\Python38\python.exe" "C:\codes\Jimin-Z8\scripts\editor_wrapper.py" code'
#
# when subprocess calling vim, the path/to/file passed in needs to include '/c' suffix,
# however, for windows apps, such as notepad++, vscode, and gvim, it cannot has the '/c' suffix, but "C:" suffix is optional.

import sys, string, os, subprocess
import re

print(sys.argv)
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
    notes = '''
    vv - vim
    np - notepad++
    vs - vscode
    This script can launch on both Linux bash and Windows gitbash.
    '''

def mk_cmd_str(editor, filename, lineno=""):
    
    if filename.startswith("/c") or filename.startswith("/C"):
        # for windows apps, have to remove '/c' suffix
        if editor == 'code' or editor == 'npp' or editor == 'gvim':
            #print("{} start with /c".format(filename))
            filename = "C:" + filename[2:]
            # filename = filename[2:] can work as well
            #print("after remove /c, {}".format(filename))

    if (editor == 'vim' or editor == "vi"):
        is_vim = 1
        command = "vim " + filename
        if (lineno != ""):
            command += " +" + lineno
    if (editor == 'gvim'):
        is_gvim = 1
        command = "gvim " + filename
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
        command = "notepad++.exe " + filename 
        if (lineno != ""):
            command += " -n" + lineno
    else:
        print("unknown editor")
        command = ""
    
    print("mk_cmd_str() returning {}".format(command))
    return command

if len(sys.argv) <= 2:
    usage()
    sys.exit(0)

if len(sys.argv) == 4:
    print("sys.argv == {}".format(sys.argv))
    # CLI: __file__ vim|code|npp filename lineno
    editor = sys.argv[1]
    filename = sys.argv[2]
    lineno = sys.argv[3]
    #print("editor: {}".format(editor))
    #print("filename: {}".format(filename))
    #print("lineno: {}".format(lineno))
    
    if (not lineno.isdigit()):
        print("ERROR: {} has been expected as a line number".format(lineno))
        sys.exit(0)

    command = mk_cmd_str(editor, filename, lineno)
    if (command == ""):
        usage()
        sys.exit(0)
    #print(command)
    print("subprocess calling {}".format(command))
    subprocess.call(command, shell=True)    # have to shell=True
    
    sys.exit(0)

if len(sys.argv) != 3:
    usage()
    sys.exit(0)

# hereafter, sys.argv == 3
print("sys.argv == {}".format(sys.argv))
# CLI: __file__ vim|code|npp filename:lineno

if (sys.argv[1] == '--help' or sys.argv[1] == '-h'):
    usage()
    sys.exit(0)

editor = sys.argv[1]
filename_line=sys.argv[2]
#print(filename_line)
#print("editor: {}".format(editor))
#print("filename_line: {}".format(filename_line))

# filename_line not a good var name as it misleading it contains filename and line number both

# trim stuff after blank space
first_blank=filename_line.find(' ')
if (-1 != first_blank):
    filename_line = filename_line[:first_blank]

# trim suffixing :
if filename_line[-1] == ':':
    filename_line = filename_line[:-1]
    #filename_line[-1] = ' '

# C:\path\to\file:123
if filename_line.startswith("c:") or filename_line.startswith("C:"):
    first_semicolon = filename_line.find(':', 2)
else:
    first_semicolon = filename_line.find(':')
#print("first_semicolon found at {}".foramt(first_semicolon)")
if (-1 != first_semicolon):
    #print(": found in filename_lineno")
    filename = filename_line[:first_semicolon]
    lineno = filename_line[first_semicolon+1:]
    second_semicolon = lineno.find(':')
    if (-1 != second_semicolon):
        lineno = lineno[:second_semicolon]
    #print("file: {}, line: {}".format(filename, lineno))

# filename123
elif (filename_line[-1:].isdigit()):
    # filename_line has trailing line number
    lineno=re.search(r"(\d+)$", filename_line).group()
    #print(lineno)
    filename=filename_line[:-len(lineno)]

else:
    filename = filename_line    # no line number provided
    lineno = ""
    

command = mk_cmd_str(editor, filename, lineno)
#print(command)
if (command == ""):
    usage()
    sys.exit(0)

print("subprocess calling {}".format(command))
subprocess.call(command, shell=True)
