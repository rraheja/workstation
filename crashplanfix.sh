#!/bin/sh
# CrashPlan fix for Synology package upgrades that keep breaking and stopping CrashPlan
# Rajesh Raheja
# October 2015
# Usage: Run this and pass the crashplan update number (the long number) as input e.g. curl -Ls <scriptURI> | sh -s <CrashPlanUpdateNumber>.

if $1
	upgradenum=$1
else
	read -p "Enter CrashPlan Upgrade Number: " upgradenum
fi

unzip -o /var/packages/CrashPlan/target/upgrade/${upgradenum}.jar "*.jar" -d /var/packages/CrashPlan/target/lib/
unzip -o /var/packages/CrashPlan/target/upgrade/${upgradenum}.jar "lang/*" -d /var/packages/CrashPlan/target/
upgradedir=`ls -d /var/packages/CrashPlan/target/upgrade/${upgradenum}.*/`
echo The following is the upgrade directory found. If more than one found, the script will fail. In that case, simply rename upgrade.sh to upgrade.sh.old in each of those directories.
echo $upgradedir
mv ${upgradedir}/upgrade.sh ${upgradedir}/upgrade.sh.old 
echo .ui_info contents: `cat /var/lib/crashplan/.ui_info  ; echo`
echo Restart CrashPlan service and check logs.
