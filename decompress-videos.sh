#!/usr/bin/env bash

if [ "$1" != "" ]; then
    cd $1

    # remove files with zero size
    echo "Removing files with zero size"
    find . -size 0 -print0 | xargs -0 rm --

    # decompress captures
    echo "Decompressing AVI files"
    find . -type f -name '*.avi' -newermt $(date +%Y-%m-%d -d '2 day ago') | \
    while read p;
    do
      ffmpeg -y -i $p -vcodec rawvideo -an -pix_fmt yuyv422 $p;
    done
else
    echo "Positional parameter 1 is empty"
fi
