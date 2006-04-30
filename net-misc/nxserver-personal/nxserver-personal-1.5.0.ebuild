# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nxserver-personal/nxserver-personal-1.5.0.ebuild,v 1.1 2006/04/30 18:11:17 stuart Exp $

inherit nxserver_1.5

DEPEND="$DEPEND
	!net-misc/nxserver-business
	!net-misc/nxserver-enterprise
	!net-misc/nxserver-freenx"

RDEPEND="${DEPEND}"

MY_PV="${PV}-91"
MY_EDITION="personal"
MY_DOWNLOAD="http://web04.nomachine.com/download/1.5.0/server/personal/nxserver-${MY_PV}.i386.rpm"
SRC_URI="http://web04.nomachine.com/download/1.5.0/server/personal/nxserver-${MY_EDITION}-${MY_PV}.i386.rpm"
KEYWORDS="~x86"
IUSE=""
