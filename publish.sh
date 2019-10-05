#!/usr/bin/env bash
script_path=$(dirname "$(readlink -f "$0")")
captures_path=/mnt/storage-2/Meteoros/
site_path=/home/thiago/site/

echo "Syncronizing BRAMON captures"
. "$script_path"/sync-bramon.sh

echo "Converting files"
. "$script_path"/convert-files.sh "$captures_path"

echo "Sincronizing with S3"
cd "$captures_path" && aws s3 sync "$captures_path" s3://meteoros/

echo "Activating Python environment"
source "$HOME"/.venvs/meteoros-floripa/bin/activate

echo "Making collection to website"
python "$script_path"/make-collection.py "$captures_path" "$site_path"

