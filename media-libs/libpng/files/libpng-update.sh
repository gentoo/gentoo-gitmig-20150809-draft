#!/bin/bash
if [ ! -f /usr/sbin/qpkg ]; then
	echo "qpkg not found, will emerge gentoolkit"
	emerge gentoolkit
fi
rm -f /tmp/pngstuff.*
echo "Scanning libraries. do not be alarmed of error messages"

find /usr/lib -type f | while read LIB; do
	ldd "${LIB}" | grep "libpng.so.2"  && /usr/sbin/qpkg -nc -f "${LIB}" >>/tmp/pngstuff.libs
done
cat /tmp/pngstuff.libs |sort | uniq |  sed 's:\(.*/.*\)-[0-9]\+.*:\1:g' >/tmp/pngstuff.libs.rebuild
echo "You will now need to rebuild the following packages"
echo "------------"
cat /tmp/pngstuff.libs.rebuild
echo "------------"
cat /tmp/pngstuff.libs.rebuild | while read PACK; do emerge ${PACK}; done
echo "--- Done with libraries ---"


echo "scanning /usr do not be alarmed of error messages"
find /usr -type f| while read FOO; do
	ldd "${FOO}" | grep libpng.so.2  && /usr/sbin/qpkg -nc -f ${FOO} >>/tmp/pngstuff.bins
done


cat /tmp/pngstuff.bins |sort | uniq | sed 's:\(.*/.*\)-[0-9]\+.*:\1:g' >/tmp/pngstuff.bins.rebuild
echo "You will now need to rebuild the following packages"
echo "-----------"
cat /tmp/pngstuff.bins.rebuild
echo "-----------"
cat /tmp/pngstuff.bins.rebuild | while read PACK; do emerge ${PACK}; done
echo "done, deleting tempfiles"
rm -f /tmp/pngstuff.*

