#!/usr/bin/env bash
script_path=$(dirname "$(readlink -f "$0")")
captures_path=/mnt/storage-2/Meteoros/
site_path=/home/thiago/site/

echo "Syncronizing BRAMON captures"
. "$script_path"/sync-bramon.sh 2> /dev/null

echo "Cleanup zero files"
. "$script_path"/cleanup-empty-files.sh "$captures_path" 2> /dev/null

echo "Converting images files"
. "$script_path"/convert-images.sh "$captures_path" 2> /dev/null

echo "Converting video files"
. "$script_path"/convert-videos.sh "$captures_path" 2> /dev/null

echo "Sincronizing with S3"
aws s3 sync "$captures_path" s3://meteoros/ 2> /dev/null

echo "Making collection to website"
python3 /home/thiago/publish/make-collection.py "$captures_path" "$site_path" 2> /dev/null
