#!/bin/bash
if [ ! -f /usr/sbin/qpkg ]; then
	if [ ! -f /usr/bin/qpkg ]; then
		echo "qpkg not found, will emerge gentoolkit"
		emerge gentoolkit
	fi
fi
if [ -f /usr/sbin/qpkg ]; then
	QPKG=/usr/sbin/qpkg
fi
if [ -f /usr/bin/qpkg ]; then
	QPKG=/usr/bin/qpkg
fi

rm -f /tmp/pngstuff.*
echo "scanning /usr do not be alarmed of error messages"
find /usr -type f -perm +u+x | while read FOO; do
	ldd "${FOO}" | grep libpng.so.2  && ${QPKG} -nc -f ${FOO} >>/tmp/pngstuff.bins
done


cat /tmp/pngstuff.bins |sort | uniq | sed 's:\(.*/.*\)-[0-9]\+.*:\1:g' >/tmp/pngstuff.bins.rebuild
echo "You will now need to rebuild the following packages"
echo "-----------"
cat /tmp/pngstuff.bins.rebuild
echo "-----------"
# cat /tmp/pngstuff.bins.rebuild | while read PACK; do emerge ${PACK}; done
echo "done, deleting tempfiles"
rm -f /tmp/pngstuff.*

