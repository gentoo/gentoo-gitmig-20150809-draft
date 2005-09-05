#!/bin/sh
#
# consolelog.sh
# For metalog -- log to a console
#
# from LFS
#

console=""
for d in /dev/vc/10 /dev/tty10 /dev/console ; do
	if [ -e ${d} ] ; then
		console=${d}
		break
	fi
done
if [ -z "${console}" ] ; then
	exit 1
fi

echo "$1 [$2] $3" > ${console}

#
# of course, you can log to multiple devices
#
#echo "$1 [$2] $3" >/dev/console
