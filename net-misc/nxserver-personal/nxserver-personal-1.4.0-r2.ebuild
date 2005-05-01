# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nxserver-personal/nxserver-personal-1.4.0-r2.ebuild,v 1.1 2005/05/01 02:06:39 stuart Exp $

inherit nxserver-1.4

DEPEND="$DEPEND
	!net-misc/nxserver-business
	!net-misc/nxserver-enterprise
	>=net-misc/nxssh-1.4.0
	>=net-misc/nx-x11-1.4.0
	>=net-misc/nxclient-1.4.0"

MY_PV="${PV}-107"

SRC_URI="http://www.nomachine.com/download/nxserver-personal/1.4.0/RedHat-9.0/nxserver-${MY_PV}.i386.rpm"
KEYWORDS="~x86"
IUSE=""
