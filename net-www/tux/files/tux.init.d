#!/sbin/runscript
# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/tux/files/tux.init.d,v 1.2 2004/02/14 04:48:54 vapier Exp $

checkconfig() {
	if [ ! -e /proc/sys/net/tux ] ; then
		# maybe they built is a module ...
		modprobe tux >& /dev/null
		if [ ! -e /proc/sys/net/tux ] ; then
			eerror "Make sure tux support is enabled in your kernel!"
			return 1
		fi
	fi
	if [ -z "${TUX_DOCROOT}" ] ; then
		eerror "You must specify TUX_DOCROOT in /etc/conf.d/tux"
		return 1
	fi
	if [ -z "${TUX_UID}" ] || [ -z "${TUX_GID}" ] ; then
		eerror "You must specify TUX_UID and TUX_GID in /etc/conf.d/tux"
		return 1
	fi
	[ -z "${TUX_THREADS}" ] && TUX_THREADS=1
	[ -z "${TUX_CGIROOT}" ] && TUX_CGIROOT=${TUX_DOCROOT}
	[ -z "${TUX_KEEPALIVE}" ] && TUX_KEEPALIVE=30
	[ -n "${TUX_MODULEPATH}" ] && TUX_MODULES="-m ${TUX_MODULEPATH} ${TUX_MODULES}"
	return 0
}

setconfig() {
	echo ${TUX_THREADS} > /proc/sys/net/tux/threads
	echo ${TUX_DOCROOT} > /proc/sys/net/tux/documentroot
	if [ -n "${TUX_LOGFILE}" ] ; then
		echo 1 > /proc/sys/net/tux/logging
		echo ${TUX_LOGFILE} > /proc/sys/net/tux/logfile
	else
		echo 0 > /proc/sys/net/tux/logging
	fi
	echo ${TUX_UID} > /proc/sys/net/tux/cgi_uid
	echo ${TUX_GID} > /proc/sys/net/tux/cgi_gid
	echo ${TUX_CGIROOT} > /proc/sys/net/tux/cgiroot
	echo ${TUX_KEEPALIVE} > /proc/sys/net/tux/keepalive_timeout
}

start() {
	checkconfig || return 1

	ebegin "Starting tux"
	setconfig
	/usr/sbin/tux -d \
		-u ${TUX_UID} -g ${TUX_GID} \
		-t ${TUX_THREADS} \
		-r ${TUX_DOCROOT} \
		${TUX_MODULES}
	eend $?
}

stop() {
	ebegin "Stopping tux"
	/usr/sbin/tux --stop
	eend $?
}
