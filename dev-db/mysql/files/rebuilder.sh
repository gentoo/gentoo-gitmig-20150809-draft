#!/bin/sh

if [ ! -e /usr/bin/qpkg ]; then
	echo "Please emerge gentoolkit before using this script."
	exit 1
fi

LINKED_WITH=libmysqlclient
rm -f /tmp/${LINKED_WITH}.*

echo "This might take a while ..."
(
	cd /
    # this is the list of locations to search
    LIST="/bin /sbin /lib /var/qmail /var/vpopmail /usr/X11R6/bin /usr/X11R6/lib /usr/bin /usr/sbin /usr/lib /usr/local/bin /usr/local/sbin /usr/local/lib /usr/qt /usr/libexec /usr/e17 /usr/kde /usr/qt /usr/libexec"
    # this is the list of limitations to apply to trim the input
    LIMITS="-type f ! -fstype proc ! -fstype tmpfs ! -fstype devfs ! -fstype usbdevfs ! -fstype ramfs ! -fstype smbfs ! -fstype devpts ! -path tmp "
    # this if any of these are true, then we want this file
    WANTED="-perm +111 -or -name '*.so' -or -name '*.so.*' -or -name '*.a' -or -name '*.a.*'"
   
	for i in ` find $LIST \(  $WANTED \) $LIMITS 2>/dev/null | sort | uniq `
	do
		ldd $i 2>/dev/null | grep ${LINKED_WITH} >/dev/null 2>&1
		[ $? -eq 0 ] && {
			qpkg -nc -f `echo $i | sed -e 's|^\.||'` >>/tmp/${LINKED_WITH}.pkgs
			echo "`echo $i | sed -e 's|^\.||'` is linked to ${LINKED_WITH} ..."
			ldd $i
			echo "---"
			echo ""
		}
	done
) | sed -e "s|\(.*\)\(${LINKED_WITH}\)\(.*\)\(=>\)|-->\1\2\3\4|" >>/tmp/${LINKED_WITH}.hits
    
cat /tmp/${LINKED_WITH}.pkgs | sort | uniq | sed 's:\(.*/.*\)-[0-9]\+.*:\1:g' \
	>>/tmp/${LINKED_WITH}.rebuildme

echo "You will need to rebuild the following packages:"
echo "------------"
cat /tmp/${LINKED_WITH}.rebuildme | grep -v "dev-db/mysql"
echo "------------"
