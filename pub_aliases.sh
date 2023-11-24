#!/usr/bin/bash
# extract pub server part from own.bashrc, trim comments, and save it in a new file
# how to use? source this script file and then run pub_aliases
pub_aliases ()
{
    sourcefile=${1:-own.bashrc}
    newfile=$sourcefile.pub.server
    echo "sourcefile: $sourcefile"
    echo "targetfile: $newfile"
    rm -f $newfile
    sed -n '/beginmark/,/endmark/p' $sourcefile > $newfile
    cp $newfile $newfile.1
    sed -i '/beginmark/,/endmark/s/\s\+#\s.*$//' $newfile
    cp $newfile $newfile.2
    sed -i '/beginmark/,/endmark/s/^\s*#.*$//' $newfile
    chmod -w $newfile
    echo "TODO: "
    echo "  on server, rm -f ~/.bashrc.pub.server*"
    echo "  in gitbash, scp own.bashrc.pub.server pae@pae-archercity.sh.intel.com:~/.bashrc.pub.server"
    echo "  on server, md5sum ~/.bashrc.pub.server > ~/.bashrc.pub.server.md5"
}

echo "pub_aliases() defined"
