#!/bin/sh
# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author:  Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-base/xfree/files/4.2.1/chooser.sh,v 1.1 2002/09/08 20:02:04 azarah Exp $

#if $XSESSION is "", source first /etc/conf.d/basic, and then /etc/rc.conf
if [ -z "${XSESSION}" ]
then
	[ -f /etc/conf.d/basic ] && source /etc/conf.d/basic
	[ -f /etc/rc.conf ] && source /etc/rc.conf
fi

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

if [ -n "${XSESSION}" ]; then
	if [ -f /etc/X11/Sessions/${XSESSION} ]; then
		if [ -x /etc/X11/Sessions/${XSESSION} ]; then
			GENTOO_EXEC="/etc/X11/Sessions/${XSESSION}"
		else
			GENTOO_EXEC="/bin/sh /etc/X11/Sessions/${XSESSION}"
		fi
	elif [ -n "${GENTOO_SESSION}" ]; then
		if [ -x "${GENTOO_SESSION}" ]; then
			GENTOO_EXEC="${GENTOO_SESSION}"
		else
			GENTOO_EXEC="/bin/sh ${GENTOO_SESSION}"
		fi
	else
		for x in "${XSESSION}" \
			"`echo ${XSESSION} | awk '{ print toupper($1) }'`" \
			"`echo ${XSESSION} | awk '{ print tolower($1) }'`"
		do
			#fall through ...
			if [ -x /bin/${x} ]; then
				GENTOO_EXEC="/bin/${x}"
				break
			elif [ -x /usr/bin/${x} ]; then
				GENTOO_EXEC="/usr/bin/${x}"
				break
			elif [ -x /usr/X11R6/bin/${x} ]; then
				GENTOO_EXEC="/usr/X11R6/bin/${x}"
				break
			elif [ -x /usr/local/bin/${x} ]; then
				GENTOO_EXEC="/usr/local/bin/${x}"
				break
			fi
		done
	fi
fi

echo "${GENTOO_EXEC}"


# vim:ts=4
