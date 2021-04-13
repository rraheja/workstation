#!/bin/bash
# Backup script - backup location can be passed in as first argument.
# Rajesh Raheja
# April 2021

echo Backing up documents on encrypted sparsebundle...
if [ -d "/Volumes/docvault" ] 
then
	rsync -vaz --exclude="#recycle" --exclude=".DS_Store*" --exclude=".Trash*" --exclude=".fseventsd" --exclude=".DocumentRevisions*" --exclude=".TemporaryItems" --exclude="Icon?" --exclude=".Spotlight*" --delete ~/Document\ Vault/ /Volumes/docvault
	echo "Backup complete on `date`." > /Volumes/docvault/lastupdated
else
	echo Sparse Bundle not open. Skipping backup.
fi

echo Backing up documents on encrypted external drive...
if [ -d "/Volumes/RRDVBAK" ] 
then
	rsync -vaz --exclude="#recycle" --exclude=".DS_Store*" --exclude=".Trash*" --exclude=".fseventsd" --exclude=".DocumentRevisions*" --exclude=".TemporaryItems" --exclude="Icon?" --exclude=".Spotlight*" --delete ~/Document\ Vault/ /Volumes/RRDVBAK
	echo "Backup complete on `date`." > /Volumes/RRDVBAK/lastupdated
else
	echo External USB drive not plugged in. Skipping backup.
fi

echo Backup complete.
