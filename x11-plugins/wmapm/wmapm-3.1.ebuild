# Copyright 1999-2002 Vitaly Kushneriuk
# Distributed under the terms of the GNU General Public License, v2.
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmapm/wmapm-3.1.ebuild,v 1.1 2002/08/30 07:44:13 seemant Exp $

S=${WORKDIR}/${P}/wmapm
DESCRIPTION="WMaker DockApp: Battery/Power status monitor for laptops"
SRC_URI="http://nis-www.lanl.gov/~mgh/WindowMaker/${P}.tar.gz"
HOMEPAGE="http://nis-www.lanl.gov/~mgh/WindowMaker/DockApps.shtml"

DEPEND="virtual/x11"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="x86 sparc sparc64"

src_compile() {
	emake || die
}

src_install () {
	mkdir -p ${D}/usr/bin
	mkdir -p ${D}/usr/man/man1
	make DESTDIR=${D}/usr install || die
}
