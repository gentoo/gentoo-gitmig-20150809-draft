# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmweather/wmweather-2.4.0.ebuild,v 1.6 2004/03/26 23:10:16 aliz Exp $

IUSE=""
DESCRIPTION="Dockable applette for WindowMaker that shows weather."
SRC_URI="http://www.godisch.de/debian/wmweather/${P}.tar.gz"
HOMEPAGE="http://www.godisch.de/debian/wmweather/"

DEPEND="virtual/x11
	net-ftp/curl"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc amd64 ~mips"

src_compile() {
	cd ${S}/src
	econf || die
	emake || die
}

src_install () {
	dodoc CHANGES COPYING README
	cd ${S}/src
	make DESTDIR=${D} install || die
}
