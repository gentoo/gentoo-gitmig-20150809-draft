#!/sbin/runscript
# Copyright 2003-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/vsftpd/files/vsftpd.init.d,v 1.6 2005/08/04 10:40:15 uberlord Exp $

depend() {
	need net
	use dns logger
}

checkconfig() {
	if [[ ! -e ${VSFTPD_CONF} ]] ; then
		eerror "Please setup ${VSFTPD_CONF} before starting vsftpd"
		eerror "There are sample configurations in /usr/share/doc/vsftpd"
		return 1
	fi

	if grep -q "^background=YES" ${VSFTPD_CONF} ; then
		local c=$( grep -c "^\(listen\|listen_ipv6\)=YES" "${VSFTPD_CONF}" )
		[[ ${c} == "1" ]] && return 0
	fi
		
	eerror "${VSFTPD_CONF} must contain background=YES and either"
	eerror "listen=YES or listen_ipv6=YES (but not both)"
	eerror "in order to start vsftpd from /etc/init.d/vsftpd"
	return 1
}

start() {
	checkconfig || return 1
	ebegin "Starting vsftpd"
	start-stop-daemon --start \
		--exec /usr/sbin/vsftpd -- ${VSFTPD_CONF}
	eend $?
}

stop() {
	ebegin "Stopping vsftpd"
	killall vsftpd
	eend $?
}
