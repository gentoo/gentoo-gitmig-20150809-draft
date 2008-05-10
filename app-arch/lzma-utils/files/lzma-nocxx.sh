#!/bin/sh

if [ "$1" = "-dc" ] ; then
	shift
	cat "$@" | lzmadec
else
	(
	echo "You've built lzma-utils without C++ support."
	echo "If you want lzma support, rebuild with C++ support."
	) 1>&2
	exit 1
fi
