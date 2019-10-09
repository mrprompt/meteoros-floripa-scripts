#!/usr/bin/env bash

if [ "$1" != "" ]; then
    cd $1

    # compress captures
    echo "Compressing AVI files"
    find . -type f -name '*.avi' | \
    while read p;
    do
      ffmpeg -y -i $p -c:v mjpeg -q:v 3 -an $p;
    done
else
    echo "compress-videos.sh <directory>"
fi
