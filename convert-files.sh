#!/usr/bin/env bash

if [ "$1" != "" ]; then
    cd $1

    # remove files with zero size
    echo "Removing files with zero size"
    find . -size 0 -print0 | xargs -0 rm --

    # converting fits images to jpg
    echo "Converting FITS files"
    find . -type f -name '*.fits' -newermt $(date +%Y-%m-%d -d '2 day ago') | \
    while read p;
    do
      if [ -f "${p%.fits}.fits_maxpixel.jpg" ];
      then
        echo "$p - ${p%.fits}.fits_maxpixel.jpg";
      else
        convert -rotate 180 "$p" "${p%.fits}.fits_maxpixel.jpg";
      fi;
    done

    # convert AVI files to MP4
    echo "Converting AVI files"
    find . -type f -name '*.avi' -newermt $(date +%Y-%m-%d -d '2 day ago') | \
    while read p;
    do
      if [ -f "${p%.avi}.mp4" ];
      then
        echo "$p - ${p%.avi}.mp4";
      else
        ffmpeg -i $p -c:v libx264 -profile:v baseline -level 3.0 -pix_fmt yuv420p "${p%.avi}.mp4";
      fi;
    done
else
    echo "Positional parameter 1 is empty"
fi
