#!/usr/bin/env bash

if [ "$1" != "" ]; then
    cd $1

    # convert AVI files to MP4
    echo "Converting AVI files"
    find . -type f -name '*.avi' -newermt $(date +%Y-%m-%d -d '7 day ago') | \
    while read p;
    do
      if [ -f "${p%.avi}.mp4" ];
      then
        echo "$p - ${p%.avi}.mp4";
      else
        ffmpeg -i "$p" -c:v libx264 -profile:v baseline -level 3.0 -pix_fmt yuv420p "${p%.avi}.mp4";
      fi;
    done
else
    echo "convert-videos.sh <directory>"
fi
