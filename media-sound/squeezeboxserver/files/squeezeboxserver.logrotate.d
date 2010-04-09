# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/squeezeboxserver/files/squeezeboxserver.logrotate.d,v 1.2 2010/04/09 04:17:59 lavajoe Exp $

/var/log/squeezeboxserver/scanner.log /var/log/squeezeboxserver/server.log /var/log/squeezeboxserver/perfmon.log {
	missingok
	notifempty
	copytruncate
	rotate 5
	size 100k
}
