# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nxserver-business/nxserver-business-1.3.0.ebuild,v 1.1 2003/12/21 16:20:16 stuart Exp $

inherit nxserver

DEPEND="$DEPEND
	!net-misc/nxserver-personal
	!net-misc/nxserver-enterprise
	>=net-misc/nxssh-1.3.0
	>=net-misc/nxproxy-1.3.0"

MY_PV="${PV}-23"

SRC_URI="http://www.nomachine.com/download/nxserver-small-business-1.3.0/RedHat-9.0/nxserver-${MY_PV}.i386.rpm"
