# Copyright 1999-2001 Vitaly Kushneriuk
# Distributed under the terms of the GNU General Public License, v2.
# Maintainer: Vitaly Kushneriuk<vitaly@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wmapm/wmapm-3.1.ebuild,v 1.3 2002/07/08 21:31:07 aliz Exp $

S=${WORKDIR}/${P}/wmapm

DESCRIPTION="WMaker DockApp: Battery/Power status monitor for laptops"
SRC_URI="http://nis-www.lanl.gov/~mgh/WindowMaker/${P}.tar.gz"
HOMEPAGE="http://nis-www.lanl.gov/~mgh/WindowMaker/DockApps.shtml"
DEPEND="x11-base/xfree"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

src_compile() {
	emake || die
}

src_install () {
	mkdir -p ${D}/usr/bin
	mkdir -p ${D}/usr/man/man1
	make DESTDIR=${D}/usr install || die
}
