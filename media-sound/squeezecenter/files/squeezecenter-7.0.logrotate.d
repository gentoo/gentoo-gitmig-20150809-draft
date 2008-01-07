# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/squeezecenter/files/squeezecenter-7.0.logrotate.d,v 1.1 2008/01/07 01:33:35 lavajoe Exp $

/var/log/squeezecenter/scanner.log /var/log/squeezecenter/server.log /var/log/squeezecenter/perfmon.log {
	missingok
	notifempty
	copytruncate
	rotate 5
	size 100k
}
