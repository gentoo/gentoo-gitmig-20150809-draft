# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nxserver-business/nxserver-business-1.4.0.ebuild,v 1.2 2005/06/29 14:22:46 stuart Exp $

inherit nxserver-1.4

MY_PV="${PV}-107"
SRC_URI="http://www.nomachine.com/download/nxserver-small-business/${PV}/RedHat-9.0/nxserver-${MY_PV}.i386.rpm"
KEYWORDS="-* x86"
DEPEND="$DEPEND
	!net-misc/nxserver-personal
	!net-misc/nxserver-enterprise
	!net-misc/nxserver-freenx"
IUSE=""
