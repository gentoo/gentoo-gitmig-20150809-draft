# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/iceked/iceked-1.3.ebuild,v 1.3 2004/03/24 11:25:44 phosphan Exp $

DESCRIPTION="IceWM keys editor"
SRC_URI="mirror://sourceforge/icecc/${P}.tar.bz2"
HOMEPAGE="http://icecc.sourceforge.net/"
LICENSE="GPL-2"
IUSE=""
KEYWORDS="x86"

DEPEND=">=x11-libs/qt-3.0.0"

SLOT="0"

src_compile () {
	econf || die
	emake || die
}

src_install () {
	einstall || die

	rm -rf ${D}/usr/doc
	dohtml ${PN}/docs/en/*.{html,sgml}
	dodoc AUTHORS ChangeLog README TODO
}
