# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/hddtemp/files/hddtemp-conf.d,v 1.3 2006/07/15 01:11:28 spock Exp $

# the hddtemp executable
HDDTEMP_EXEC=/usr/sbin/hddtemp

# various options to pass to the daemon
HDDTEMP_OPTS="-l 127.0.0.1"

# a list of drives to check
HDDTEMP_DRIVES="/dev/hda /dev/hdb"

