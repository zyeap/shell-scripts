#!/usr/bin/env bash

# YouTube to mp3 downloader script
# Requires youtube-dl and ffmpeg 
# Example usage: ./yt2mp3.sh "https://www.youtube.com/watch?v=AOFnLntygwE"

URL=$1

check_packages(){
    PKGS="youtube-dl ffmpeg"
    rc=0
    for pkg in $PKGS
    do
        # which $pkg will search for existence of package 
        # redirect stdout and stderr to /dev/null to bury output
        # below is shorthand for cmd > /dev/null 2>&1
        which $pkg &> /dev/null    

        # $? will get the exit status of the last command
        # echo $? to visually see exit status, 0 = success, 1 = failure
        if [[ $? -eq 1 ]]; then
            echo "$pkg package is not installed, please install $pkg for script to run" 
            rc=1
        fi
    done
    return $rc
}

get_mp3() {
    youtube-dl -f bestaudio $URL --extract-audio --audio-format mp3
}

# run check_packages and check exit status
check_packages
if [[ $? -eq 1 ]]; then
    echo "Exiting program..."
    exit
else
    if [[ -z $URL ]]; then
        echo "Please provide URL"
        exit
    else
        get_mp3
    fi
fi



