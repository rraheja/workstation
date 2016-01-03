#!/bin/sh
# Disable the annoying eaDir folders
# Rajesh Raheja
# January 2016
# Usage: run as root

echo Disabling the thumbnail generation services
synoservicecfg --list | grep synomkthumbd
synoservicecfg --stop synomkthumbd

echo Finding number of @eaDir folders to remove...
find . -type d -name "@eaDir" | wc -l

echo Removing existing eaDir folders
find /volume1 -name "@eaDir" -type d -print0 | xargs -0 rm -rf
