# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2         
# $Header: /var/cvsroot/gentoo-x86/media-sound/daapd/files/daapd.conf.d,v 1.1 2004/03/31 02:20:20 eradicator Exp $

# Options to pass to the daapd process that will *always*
# be run. Most people should not change this line ...
# however, if you know what you're doing, feel free to tweak
# See the README in /usr/share/daapd*/ for more info.
DAAPD_OPTS=""

# By default daapd will run as root but it seems there is nothing
# which requires that. Uncommenting the line below will start the
# daapd daemon as the user you specify.
#DAAPD_RUNAS="nobody:nobody"
