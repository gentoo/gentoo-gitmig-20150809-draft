# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-im/mu-conference/files/mu-conference-conf.d,v 1.1 2004/07/06 18:07:27 humpback Exp $

CONFIG= "/etc/jabber/muctrans.xml"
PIDFILE= grep pid ${CONFIG} | sed -e 's/<[^>]*>//g' | sed s/' '//g
	
