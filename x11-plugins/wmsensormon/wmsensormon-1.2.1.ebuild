# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmsensormon/wmsensormon-1.2.1.ebuild,v 1.2 2005/01/28 23:39:56 s4t4n Exp $

IUSE=""
S=${WORKDIR}/${P/_/-}/${PN}
DESCRIPTION="WindowMaker DockApp: Monitors sensors using lm_sensors"
SRC_URI="mirror://sourceforge/wmsensormon/${P/_/-}.tar.gz"
HOMEPAGE="http://wmsensormon.sourceforge.net"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64"
DEPEND="virtual/x11
	>=sys-apps/lm-sensors-2.8.7"

src_compile() {
	cd ${S}
	mv Makefile Makefile.orig
	sed 's/^CFLAGS/#CFLAGS/' Makefile.orig > Makefile
	rm Makefile.orig
	emake || die
}

src_install () {
	cd ${S}
	dobin wmsensormon
	#unbzip manpage - Will be updated in 1.2 release
	doman wmsensormon.1
	cd ..
	dodoc CHANGELOG COPYING INSTALL README TODO
}
