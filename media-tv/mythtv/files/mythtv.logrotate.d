# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/mythtv/files/mythtv.logrotate.d,v 1.1 2007/03/10 04:36:10 cardoe Exp $

/var/log/mythtv/mythbackend.log /var/log/mythtv/mythfrontend.log {
weekly
create 660 mythtv video
notifempty
size 5M
sharedscripts
missingok
postrotate
/bin/kill -HUP `cat /var/run/mythbackend.pid`
endscript
}
