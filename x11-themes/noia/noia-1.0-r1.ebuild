# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/noia/noia-1.0-r1.ebuild,v 1.1 2005/07/12 23:42:25 flameeyes Exp $

DESCRIPTION="The Noia icon theme"
SRC_URI="http://es.kde.org/downloads/noia-kde-icons-1.00.tgz"
HOMEPAGE="http://www.carlitus.net"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
SLOT="0"
LICENSE="LGPL-2.1"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/noia_kde_100"

RESTRICT="nostrip"

src_compile() {
	return 1
}

src_install(){
	dodir /usr/share/icons/${PN}
	cp -r ${S}/* ${D}/usr/share/icons/${PN}
}
