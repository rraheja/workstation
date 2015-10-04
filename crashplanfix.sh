#!/bin/sh
# CrashPlan fix for Synology package upgrades that keep breaking and stopping CrashPlan
# Rajesh Raheja
# October 2015
# Usage: Run this and pass the crashplan update number (the long number) as input e.g. curl -Ls <scriptURI> | sh

echo The following upgrades are found:
ls -l /var/packages/CrashPlan/target/upgrade/*.jar

if [ -z "$1" ];
then
	echo "No CrashPlan Upgrade Number provided"
	exit 1;
else
	upgradenum="$1"
	echo "Processing upgrade $upgradenum"
fi

unzip -o /var/packages/CrashPlan/target/upgrade/${upgradenum}.jar "*.jar" -d /var/packages/CrashPlan/target/lib/
unzip -o /var/packages/CrashPlan/target/upgrade/${upgradenum}.jar "lang/*" -d /var/packages/CrashPlan/target/

upgradedirs=`ls -ld /var/packages/CrashPlan/target/upgrade/${upgradenum}.*/ | wc -l`
if [ $upgradedirs > 1 ];
then
	echo More than one upgrade directory found. In that case, simply rename upgrade.sh to upgrade.sh.old in each of those directories.
	echo "mv <dir>/upgrade.sh <dir>/upgrade.sh.old 
	echo $upgradedirs
	exit 1;
fi

upgradedir=`ls -d /var/packages/CrashPlan/target/upgrade/${upgradenum}.*/`
echo Processing folder $upgradedir
mv ${upgradedir}/upgrade.sh ${upgradedir}/upgrade.sh.old 
echo The contents of /var/lib/crashplan/.ui_info file: `cat /var/lib/crashplan/.ui_info  ; echo`
echo Restart CrashPlan service and check logs.
