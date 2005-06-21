#!/sbin/runscript
# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/rt/files/3.4.2/rt.init.d,v 1.2 2005/06/21 11:09:49 rl03 Exp $

depend() {
	use mysql postgresql lighttpd
}

start() {
	ebegin "Starting RT"
	rm -f ${FCGI_SOCKET_PATH}
	env -i PATH=$PATH FCGI_SOCKET_PATH=${FCGI_SOCKET_PATH}\
		/sbin/start-stop-daemon -o --quiet --start \
		--startas ${RTPATH}/bin/mason_handler.fcgi \
		--pidfile ${PIDFILE} -c ${RTUSER} -g ${RTGROUP} -b -d ${RTPATH}
	# mason_handler.fcgi doesn't bg itself, so have start-stop-demon do that
	# if you experience problems, delete the -b flag above
	# and check if you get any errors

	# make sure lighttpd can use the socket
	while true; do
		[[ -a ${FCGI_SOCKET_PATH} ]] && break
		sleep 1
	done
	chmod g+rwx ${FCGI_SOCKET_PATH}
	eend $?
}

stop() {
	ebegin "Stopping RT"
	/sbin/start-stop-daemon -o --quiet --stop --pidfile ${PIDFILE}
	eend $?
}

restart() {
	svc_stop
	svc_start
}
