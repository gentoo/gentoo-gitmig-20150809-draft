# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nxserver-personal/nxserver-personal-1.4.0.ebuild,v 1.1 2004/08/30 20:46:28 stuart Exp $

inherit nxserver-1.4

DEPEND="$DEPEND
	!net-misc/nxserver-business
	!net-misc/nxserver-enterprise
	>=net-misc/nxssh-1.4.0
	>=net-misc/nx-x11-1.4.0
	>=net-misc/nxclient-1.4.0"

MY_PV="${PV}-66"

SRC_URI="http://www.nomachine.com/download/snapshot/nxbinaries/Linux/nxserver-${MY_PV}.i386.rpm"
KEYWORDS="~x86"
IUSE=""
