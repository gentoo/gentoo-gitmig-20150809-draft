# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2.
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmapm/wmapm-3.1-r1.ebuild,v 1.1 2002/11/03 15:47:17 seemant Exp $

S=${WORKDIR}/${P}/${PN}
DESCRIPTION="WindowMaker DockApp: Battery/Power status monitor for laptops"
SRC_URI="http://nis-www.lanl.gov/~mgh/WindowMaker/${P}.tar.gz"
HOMEPAGE="http://nis-www.lanl.gov/~mgh/WindowMaker/DockApps.shtml"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND="virtual/x11"

src_compile() {
	emake || die
}

src_install () {
	cd ${S}
	dobin wmapm
	doman wmapm.1

	cd ..
	dodoc BUGS CHANGES COPYING HINTS INSTALL README TODO
}
