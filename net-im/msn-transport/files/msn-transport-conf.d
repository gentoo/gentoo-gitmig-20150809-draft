# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-im/msn-transport/files/msn-transport-conf.d,v 1.1 2004/07/09 18:07:04 humpback Exp $

CONFIG="/etc/jabber/msnt.xml"

#Need to find a way to fix the "double" expansion 
#PIDFILE= grep pid ${CONFIG} | sed -e 's/<[^>]*>//g' | sed s/' '//g
PIDFILE="/var/log/jabber/msnt.pid"
