#!/usr/bin/env bash

if [ "$1" != "" ]; then
    cd $1

    # remove files with zero size
    echo "Removing files with zero size"
    find . -size 0 -print0 | xargs -0 rm -- 2> /dev/null
else
    echo "cleanup-empty-files.sh <directory>"
fi
