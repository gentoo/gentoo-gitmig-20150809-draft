# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nxserver-personal/nxserver-personal-1.2.2-r1.ebuild,v 1.1 2003/09/10 17:17:12 stuart Exp $

inherit nxserver

DEPEND="$DEPEND
	!net-misc/nxserver-business
	!net-misc/nxserver-enterprise
	=net-misc/nxssh-1.2.2-r1
	=net-misc/nxproxy-1.2.2-r1"

MY_PV="${PV}-85"

SRC_URI="http://www.nomachine.com/download/nxserver-PE-1.2.2/RedHat-9.0/nxserver-1.2.2-85.i386.rpm"
