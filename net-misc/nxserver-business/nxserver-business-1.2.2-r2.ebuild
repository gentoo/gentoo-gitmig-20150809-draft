# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nxserver-business/nxserver-business-1.2.2-r2.ebuild,v 1.2 2003/10/28 15:07:19 mholzer Exp $

inherit nxserver

DEPEND="$DEPEND
	!net-misc/nxserver-personal
	!net-misc/nxserver-enterprise
	=net-misc/nxssh-1.2.2-r1
	=net-misc/nxproxy-1.2.2-r1"

MY_PV="${PV}-86"

SRC_URI="http://www.nomachine.com/download/nxserver-SBE-1.2.2/RedHat-9.0/nxserver-1.2.2-86.i386.rpm"
