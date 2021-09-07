#!/usr/bin/env bash

# compression assistant utility

compress() {
    echo "Enter full directory path"
    read fullpath
    dir=$(basename $fullpath)
    tar czf $dir.tgz $fullpath  
    echo "Created $dir.tgz file in current directory"
}

extract() {
    echo "Enter full .tgz file path"
    read fullpath
    dir=$(basename $fullpath)
    dir="${dir%.*}"
    echo "Extract to different location? (leave empty for current directory)"
    read extractdir
    if [ ! $extractdir ]; then
        tar xzf $fullpath    
        echo "Created $dir in current directory"
    else
        tar xzf $fullpath -C $extractdir
        echo "Created $dir in $extractdir"
    fi 
}

view() {
    echo "Enter full .tgz file path"
    read fullpath
    tar tzvf $fullpath
}


echo "-----------------------------------"
echo "Compression assistant (tar + gzip)"
echo "-----------------------------------"
echo "1. Compress directory into .tgz file"
echo "2. Extract .tgz file contents"
echo "3. View .tgz contents"
echo "4. Exit" 
echo "-----------------------------------"
echo "Enter selection: "
read choice

case $choice in
    1)      compress;;     
    2)      extract;;
    3)      view;;
    4)      exit;;
    *)      echo "Unknown choice"; exit 1;;
esac
