#!/usr/bin/env bash

if [ "$1" != "" ]; then
    cd $1

    # decompress captures
    echo "Decompressing AVI files"
    find . -type f -name '*.avi' | \
    while read p;
    do
      ffmpeg -y -i $p -vcodec rawvideo -an -pix_fmt yuyv422 $p;
    done
else
    echo "decompress-videos.sh <directory>"
fi
