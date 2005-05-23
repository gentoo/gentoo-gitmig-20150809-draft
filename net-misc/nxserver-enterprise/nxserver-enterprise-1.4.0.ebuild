# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nxserver-enterprise/nxserver-enterprise-1.4.0.ebuild,v 1.1 2005/05/23 19:04:15 stuart Exp $

inherit nxserver-1.4

MY_PV="${PV}-107"
SRC_URI="http://www.nomachine.com/download/nxserver-enterprise/${PV}/RedHat-9.0/nxserver-${MY_PV}.i386.rpm"
KEYWORDS="-* x86"
DEPEND="$DEPEND
	!net-misc/nxserver-personal
	!net-misc/nxserver-business
	!net-misc/nxserver-freenx"
IUSE=""
