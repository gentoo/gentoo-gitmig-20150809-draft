#!/bin/bash
# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-base/xfree/files/4.2.1/startDM.sh,v 1.1 2002/09/08 20:02:04 azarah Exp $

source /etc/init.d/functions.sh


if [ -e ${svcdir}/options/xdm/service ]
then
	retval=0
	EXE="`cat ${svcdir}/options/xdm/service`"

	/sbin/start-stop-daemon --start --quiet --exec ${EXE}
	retval=$?
	sleep 5
	
	if [ "${retval}" -ne 0 ]
	then
		# there was a error running the DM
		einfo "ERROR: could not start the Display Manager..."
		# make sure we do not have a misbehaving DM
		killall -9 ${EXE##*/}
	fi
fi


# vim:ts=4
