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
	for i in `find . -regex './bin.*' \
		-or -regex './lib.*' \
		-or -regex './sbin.*' \
		-or -regex './usr/bin.*' \
		-or -regex './usr/sbin.*' \
		-or -regex './usr/lib.*' \
		-or -regex './usr/kde.*' \
		-or -regex './usr/qt.*'`
	do
	[ -x $i -a -f $i ] && {
		ldd $i 2>/dev/null | grep ${LINKED_WITH} >/dev/null 2>&1
		[ $? -eq 0 ] && {
			qpkg -nc -f `echo $i | sed -e 's|^\.||'` >>/tmp/${LINKED_WITH}.pkgs
			echo "`echo $i | sed -e 's|^\.||'` is linked to ${LINKED_WITH} ..."
			ldd $i
			echo "---"
			echo ""
		}
	}
	done
) | sed -e "s|\(.*\)\(${LINKED_WITH}\)\(.*\)\(=>\)|-->\1\2\3\4|" >>/tmp/${LINKED_WITH}.hits

cat /tmp/${LINKED_WITH}.pkgs | sort | uniq | sed 's:\(.*/.*\)-[0-9]\+.*:\1:g' \
	>>/tmp/${LINKED_WITH}.rebuildme

echo "You will need to rebuild the following packages:"
echo "------------"
cat /tmp/${LINKED_WITH}.rebuildme | grep -v "dev-db/mysql"
echo "------------"
