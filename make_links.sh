#!/bin/bash
file_location=$(dirname $0)
echo -e $file_location	
for file in bashrc,path,exports,aliases,functions,extra,secrets,bash_profile,zshrc; do
    [[ -f $file_location/$file ]] && ln -s $file_location/$file ~/.$file
done
