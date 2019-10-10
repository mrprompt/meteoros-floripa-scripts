#!/usr/bin/env bash

cd /mnt/

isPathMounted() {
  findmnt -rno        TARGET "$1" >/dev/null;
}

DIRS=(BRAMON-1 BRAMON-2 BRAMON-3 BRAMON-4)

# shellcheck disable=SC2068
for HOST in ${DIRS[@]}; do
  if isPathMounted "${HOST}/"; then
    captures="${HOST}/!data/"

    rsync -aruvP "${captures}" "/mnt/storage-2/Meteoros/"
  fi

  ((ITER++))
done

exit 0