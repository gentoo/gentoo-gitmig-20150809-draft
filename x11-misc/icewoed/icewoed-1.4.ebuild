# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/icewoed/icewoed-1.4.ebuild,v 1.1 2003/04/14 12:07:44 phosphan Exp $

DESCRIPTION="IceWM winoptions editor."
SRC_URI="http://tsa.dyndns.org/mirror/xvadim/${P}.tar.bz2"
HOMEPAGE="http://tsa.dyndns.org/mirror/xvadim/"

DEPEND=">=qt-3.0.0"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

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
