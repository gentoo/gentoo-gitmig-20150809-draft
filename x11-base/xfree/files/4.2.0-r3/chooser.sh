#!/bin/sh
# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-base/xfree/files/4.2.0-r3/chooser.sh,v 1.1 2002/01/23 13:54:09 danarmak Exp $

#find a match for $XSESSION in /etc/X11/Sessions
GENTOO_SESSION=""
for x in /etc/X11/Sessions/*
do
	if [ "`echo ${x##*/} | awk '{ print toupper($1) }'`" \
		= "`echo ${XSESSION} | awk '{ print toupper($1) }'`" ]
	then
		GENTOO_SESSION=${x}
		break
	fi
done

GENTOO_EXEC=""

if [ -n "$XSESSION" ]; then
	if [ -f "/etc/X11/Sessions/${XSESSION}" ]; then
		if [ -x "/etc/X11/Sessions/${XSESSION}" ]; then
			GENTOO_EXEC="/etc/X11/Sessions/${XSESSION}"
		else
			GENTOO_EXEC="/bin/sh /etc/X11/Sessions/${XSESSION}"
		fi
	elif [ -n "$GENTOO_SESSION" ]; then
		if [ -x "$GENTOO_SESSION" ]; then
			GENTOO_EXEC="$GENTOO_SESSION"
		else
			GENTOO_EXEC="/bin/sh $GENTOO_SESSION"
		fi
	else
		for x in "$XSESSION" \
			"`echo $XSESSION | awk '{ print toupper($1) }'`" \
			"`echo $XSESSION | awk '{ print tolower($1) }'`"
		do
			#fall through ...
			if [ -x "/bin/${x}" ]; then
				GENTOO_EXEC="/bin/${x}"
				break
			elif [ -x "/usr/bin/${x}" ]; then
				GENTOO_EXEC="/usr/bin/${x}"
				break
			elif [ -x "/usr/X11R6/bin/${x}" ]; then
				GENTOO_EXEC="/usr/X11R6/bin/${x}"
				break
			elif [ -x "/usr/local/bin/${x}" ]; then
				GENTOO_EXEC="/usr/local/bin/${x}"
				break
			fi
		done
	fi
fi

echo "$GENTOO_EXEC"
