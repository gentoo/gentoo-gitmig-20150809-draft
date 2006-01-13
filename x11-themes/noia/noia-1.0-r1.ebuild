# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/noia/noia-1.0-r1.ebuild,v 1.5 2006/01/13 18:07:52 gustavoz Exp $

DESCRIPTION="The Noia icon theme"
SRC_URI="http://es.kde.org/downloads/noia-kde-icons-1.00.tgz"
HOMEPAGE="http://www.carlitus.net"
KEYWORDS="amd64 ppc sparc x86"
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
