#!/usr/bin/env bash
#
# Active S-Video input from capture cards and
# set input method as NTSC

v4l2-ctl -i 1 -d 0 --set-standard=0
v4l2-ctl -i 2 -d 0 --set-standard=0
v4l2-ctl -i 3 -d 0 --set-standard=0
