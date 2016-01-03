#!/bin/sh
# Disable the annoying eaDir folders
# Rajesh Raheja
# January 2016
# Usage: run as root

echo Disabling the thumbnail generation services

cd /usr/syno/etc.defaults/rc.d/
S66synoindexd.sh stop
S77synomkthumbd.sh stop
S88synomkflvd.sh stop
S99iTunes.sh stop
chmod 000 S66fileindexd.sh S66synoindexd.sh S77synomkthumbd.sh S88synomkflvd.sh S99iTunes.sh

echo Finding number of @eaDir folders to remove...
find . -type d -name "@eaDir" | wc -l

echo Removing existing eaDir folders
find /volume1 -name "@eaDir" -type d -print0 | xargs -0 rm -rf

echo Finding number of @eaDir folders remaining (hopefully 0)
find . -type d -name "@eaDir" | wc -l
