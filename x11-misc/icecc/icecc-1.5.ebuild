# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/icecc/icecc-1.5.ebuild,v 1.3 2003/04/25 16:08:03 vapier Exp $

DESCRIPTION="IceWM Control Center"
SRC_URI="http://tsa.dyndns.org/mirror/xvadim/${P}.tar.bz2"
HOMEPAGE="http://tsa.dyndns.org/mirror/xvadim/"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

DEPEND=">=x11-libs/qt-3.0.0"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die

	rm -rf ${D}/usr/doc
	dohtml ${PN}/docs/en/*.{html,sgml}
	dodoc AUTHORS ChangeLog README TODO
}
