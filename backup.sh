#!/bin/bash
# Backup script - backup location can be passed in as first argument.
# Rajesh Raheja 08/23/2013

HOSTNAME=`hostname`
# BACKUPDIR=${1:-rraheja@rraheja-nas.local:/mnt/Share/Backups/"$HOSTNAME"}
BACKUPDIR=${1:-/mnt/Share/Backups/"$HOSTNAME"}

exec > >(tee /tmp/backup.log)
exec 2>&1

osname=`uname`
if [[ "$osname" == 'Darwin' ]]; then
	echo INFO: Executing on a Mac.
elif [[ "$osname" == 'Linux' ]]; then
	echo Exporting APT keys
	apt-key exportall > /etc/apt/repo.keys
fi

echo Archiving files
tar -cvzf /tmp/backup.tgz --exclude-caches-all --ignore-failed-read -T - << EOF
/etc/NetworkManager/NetworkManager.conf
/etc/apt/
/etc/exports
/etc/forked-daapd.conf
/etc/mdm/Init/Default
/etc/minidlna.conf
/etc/network/interfaces
/etc/ppp/chap-secrets
/etc/ppp/pptpd-options
/etc/pptpd.conf
/etc/rc.local
/etc/samba/smb.conf
/etc/ssh/sshd_config
/etc/sysctl.conf
/etc/vsftpd.conf
/etc/yum.repos.d
/etc/yum/
/etc/init.d/
/etc/sysconfig/
/etc/fstab
/etc/sudoers
/etc/sudoers.d/
/etc/modules
/etc/modprobe.d/
/home/rraheja/Documents/
/home/rraheja/.ssh/
/home/rraheja/.config/
/home/rraheja/.gnome2/
/home/rraheja/.linuxmint/
/home/rraheja/.vnc/
/home/rraheja/.VirtualBox/
/Users/rahra01/Documents
EOF

sudo -u rraheja scp /tmp/backup.tgz "$BACKUPDIR"
echo Backup complete on `date`.
