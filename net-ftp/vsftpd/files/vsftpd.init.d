#!/sbin/runscript
# Copyright 2003-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/vsftpd/files/vsftpd.init.d,v 1.4 2004/10/01 03:16:13 jforman Exp $

depend() {
	need net
	use dns logger
}

checkconfig() {
	if [ ! -e ${VSFTPD_CONF} ] ; then
		eerror "Please setup ${VSFTPD_CONF} before starting vsftpd"
		eerror "There are sample configurations in /usr/share/doc/vsftpd"
		return 1
	else
		( grep -q "^background=YES" ${VSFTPD_CONF}  && grep -q "^listen=YES" ${VSFTPD_CONF} )  || {
		eerror "${VSFTPD_CONF} must contain background=YES and listen=YES"
		eerror "in order to start vsftpd from /etc/init.d/vsftpd"
		return 2
	}
	fi
}

start() {
	checkconfig || return 1
	ebegin "Starting vsftpd"
	start-stop-daemon --start --quiet \
		--exec /usr/sbin/vsftpd ${VSFTPD_CONF}
	eend $?
}

stop() {
	ebegin "Stopping vsftpd"
	start-stop-daemon --stop --quiet --exec /usr/sbin/vsftpd
	eend $?
}
