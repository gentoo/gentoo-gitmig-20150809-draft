# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2.
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmsensormon/wmsensormon-1.2_beta.ebuild,v 1.4 2003/05/29 09:38:48 seemant Exp $

S=${WORKDIR}/${P/_/-}/${PN}
DESCRIPTION="WindowMaker DockApp: Monitors sensors using lm_sensors"
SRC_URI="mirror://sourceforge/wmsensormon/${P/_/-}.tar.gz"
HOMEPAGE="http://wmsensormon.sourceforge.net"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
DEPEND="virtual/x11
	sys-apps/lm-sensors"

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
	bzip2 -d wmsensormon.1.bz2
	doman wmsensormon.1
	cd ..
	dodoc CHANGELOG COPYING INSTALL README TODO
}
