# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/rt/files/rt.conf.d,v 1.2 2008/04/03 09:57:12 hollow Exp $

# Config file for /etc/init.d/rt

RTUSER=rt
RTGROUP=lighttpd

# set RTPATH to rt's root
RTPATH=/var/www/localhost/@@PF@@

FCGI_SOCKET_PATH=${RTPATH}/var/appSocket
PIDFILE=${RTPATH}/var/pid
