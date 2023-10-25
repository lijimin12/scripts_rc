#!/usr/bin/bash
# extract pub server part from own.bashrc, trim comments, and save it in a new file
pub_aliases ()
{
    sourcefile=${1:-own.bashrc}
    newfile=$sourcefile.pub.server
    echo $sourcefile
    echo $newfile
    sed -n '/beginmark/,/endmark/p' $sourcefile > $newfile
    cp $newfile $newfile.1
    sed -i '/beginmark/,/endmark/s/\s#\s.*$//' $newfile
    cp $newfile $newfile.2
    sed -i '/beginmark/,/endmark/s/^\s*#.*$//' $newfile
}

