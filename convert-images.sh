#!/usr/bin/env bash

if [ "$1" != "" ]; then
    cd $1

    # converting fits images to jpg
    echo "Converting FITS files"
    find . -type f -name '*.fits' -newermt $(date +%Y-%m-%d -d '7 day ago') | \
    while read p;
    do
      if [ -f "${p%.fits}.fits_maxpixel.jpg" ];
      then
        echo "$p - ${p%.fits}.fits_maxpixel.jpg";
      else
        convert -rotate 180 "$p" "${p%.fits}.fits_maxpixel.jpg";
      fi;
    done
else
    echo "convert-images.sh <directory>"
fi
