# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/rt/files/3.4.2/rt.conf.d,v 1.1 2005/06/21 02:12:38 rl03 Exp $

# Config file for /etc/init.d/rt

RTUSER=rt
RTGROUP=lighttpd

# set RTPATH to rt's root
RTPATH=/var/www/localhost/rt-3.4.2

FCGI_SOCKET_PATH=${RTPATH}/var/appSocket
PIDFILE=${RTPATH}/var/pid
