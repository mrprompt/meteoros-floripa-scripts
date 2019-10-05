#!/usr/bin/env bash

if [ "$1" != "" ]; then
    cd $1

    # remove files with zero size
    echo "Removing files with zero size"
    find . -size 0 -print0 | xargs -0 rm --

    # compress captures
    echo "Compressing AVI files"
    find . -type f -name '*.avi' -newermt $(date +%Y-%m-%d -d '2 day ago') | \
    while read p;
    do
      ffmpeg -y -i $p -c:v mjpeg -q:v 3 -an $p;
    done
else
    echo "Positional parameter 1 is empty"
fi
