#!/bin/sh
# Enable the thumbnail generation process and also the annoying eaDir folders
# Rajesh Raheja
# January 2016
# Usage: run as root

echo Enabling the thumbnail generation services

cd /usr/syno/etc.defaults/rc.d/
chmod 655 S66fileindexd.sh S66synoindexd.sh S77synomkthumbd.sh S88synomkflvd.sh S99iTunes.sh
S66synoindexd.sh start
S77synomkthumbd.sh start
S88synomkflvd.sh start
S99iTunes.sh start
