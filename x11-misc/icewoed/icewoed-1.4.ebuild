# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/icewoed/icewoed-1.4.ebuild,v 1.3 2003/05/19 14:11:29 phosphan Exp $

DESCRIPTION="IceWM winoptions editor."
SRC_URI="mirror://sourceforge/icecc/${P}.tar.bz2"
HOMEPAGE="http://icecc.sourceforge.net/"

DEPEND=">=qt-3.0.0"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile () {
	econf || die
	emake || die
}

src_install () {
	einstall || die

	rm -rf ${D}/usr/doc
	dohtml ${PN}/docs/en/*.{html,sgml}

	dodoc AUTHORS README TODO
}
