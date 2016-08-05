#!/bin/sh
# CrashPlan App fixes for headless server - run this after a new/upgraded CrashPlan client app
# Assumes the CrashPlan server is on a Synology NAS running at 192.168.1.12 and the .ui_info file is in a Dropbox folder named .ssh
# Rajesh Raheja
# October 2015

echo "Setting up CrashPlan for headless server operations"
echo "Stopping locally installed CrashPlan server. This may require administrator password."
sudo launchctl unload -w /Library/LaunchDaemons/com.crashplan.engine.plist
ps auxww | grep -i CrashPlanService
echo "Ensure CrashPlan is not running above."
echo "Changing CrashPlan UI to point to NAS server."
sudo sed -i inplace 's/#serviceHost=127.0.0.1/serviceHost=192.168.1.12/' /Applications/CrashPlan.app/Contents/Resources/Java/conf/ui.properties
echo "Changing CrashPlan Menu Helper App to point to NAS server."
sudo sed -i inplace 's/127.0.0.1/192.168.1.12/' /Applications/CrashPlan.app/Contents/Helpers/CrashPlan\ menu\ bar.app/Contents/Info.plist
echo "Updating UI key to allow connection to NAS server. Login to the NAS and perform 'cat /var/lib/crashplan/.ui_info' to get the value."
sudo rm -f /Library/Application\ Support/CrashPlan/.ui_info
sudo cp ~/.ssh/crashplan.ui_info /Library/Application\ Support/CrashPlan/.ui_info
sudo chmod 644 /Library/Application\ Support/CrashPlan/.ui_info
