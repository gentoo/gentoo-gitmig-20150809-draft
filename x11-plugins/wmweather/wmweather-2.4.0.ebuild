# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmweather/wmweather-2.4.0.ebuild,v 1.14 2005/02/06 17:21:56 corsair Exp $

IUSE=""
DESCRIPTION="Dockable applet for WindowMaker that shows weather."
HOMEPAGE="http://www.godisch.de/debian/wmweather/"
SRC_URI="http://www.godisch.de/debian/wmweather/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc amd64 ~mips ppc ppc64"

DEPEND="virtual/x11
	net-misc/curl"

src_compile() {
	cd ${S}/src
	econf || die
	emake || die
}

src_install() {
	dodoc CHANGES README
	cd ${S}/src
	make DESTDIR=${D} install || die
}
