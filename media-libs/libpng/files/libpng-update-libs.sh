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
echo "Scanning libraries. do not be alarmed of error messages"

find /usr/lib -type f -perm +u+x | while read LIB; do
	ldd "${LIB}" | grep "libpng.so.2"  && ${QPKG} -nc -f "${LIB}" >>/tmp/pngstuff.libs
done
cat /tmp/pngstuff.libs |sort | uniq |  sed 's:\(.*/.*\)-[0-9]\+.*:\1:g' >/tmp/pngstuff.libs.rebuild
echo "You will now need to rebuild the following packages"
echo "------------"
cat /tmp/pngstuff.libs.rebuild
echo "------------"
# cat /tmp/pngstuff.libs.rebuild | while read PACK; do emerge ${PACK}; done
echo "--- Done with libraries ---"


rm -f /tmp/pngstuff.*

