#!/bin/sh
# Enable the thumbnail generation process and also the annoying eaDir folders
# Rajesh Raheja
# January 2016
# Usage: run as root

echo Enabling the thumbnail generation services
synoservicecfg --start synomkthumbd
synoservicecfg --list | grep synomkthumbd
