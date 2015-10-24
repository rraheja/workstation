#!/bin/bash
# Backup script - backup location can be passed in as first argument.
# Rajesh Raheja
# October 2015

HOSTNAME=`hostname`
BACKUPDIR=${1:-/mnt/Share/Backups/"$HOSTNAME"}

exec > >(tee /tmp/backup.log)
exec 2>&1

osname=`uname`
if [[ "$osname" == 'Darwin' ]]; then
	echo INFO: Executing on a Mac.
	taropts=""
elif [[ "$osname" == 'Linux' ]]; then
	echo Exporting APT keys
	apt-key exportall > /etc/apt/repo.keys
	taropts=" --exclude-caches-all --ignore-failed-read "
fi

echo Archiving files
tar -cvzf /tmp/backup.tgz $taropts -T - << EOF
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
$HOME/.ssh/
$HOME/.config/
$HOME/.gnome2/
$HOME/.linuxmint/
$HOME/.vnc/
EOF

scp /tmp/backup.tgz "$BACKUPDIR"

# rsync -av ~ /Volumes/ARCHIVE --exclude=".Trash" --exclude="Library/Caches" --exclude="Library/Logs" --exclude=".sh_history" --progress | grep -v "/$"

echo Backup complete on `date`.
