# Copyright 1999-2002 Vitaly Kushneriuk
# Distributed under the terms of the GNU General Public License, v2.
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmapm/wmapm-3.1.ebuild,v 1.2 2002/11/30 22:00:53 vapier Exp $

DESCRIPTION="WMaker DockApp: Battery/Power status monitor for laptops"
SRC_URI="http://nis-www.lanl.gov/~mgh/WindowMaker/${P}.tar.gz"
HOMEPAGE="http://nis-www.lanl.gov/~mgh/WindowMaker/DockApps.shtml"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

DEPEND="virtual/x11"

S=${WORKDIR}/${P}/wmapm

src_compile() {
	emake || die
}

src_install() {
	dodir /usr/bin /usr/man/man1
	make DESTDIR=${D}/usr install || die
}
