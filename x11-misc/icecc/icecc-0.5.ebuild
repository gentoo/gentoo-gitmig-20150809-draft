# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/icecc/icecc-0.5.ebuild,v 1.9 2003/04/25 16:08:03 vapier Exp $

DESCRIPTION="IceWM Control-Center"
SRC_URI="http://www.selena.kherson.ua/xvadim/${P}.tar.bz2"
HOMEPAGE="http://www.selena.kherson.ua/xvadim/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"

DEPEND="virtual/x11
	x11-libs/qt
	x11-misc/icets
	x11-misc/icebgset
	x11-misc/icesndcfg"
RDEPEND="x11-wm/icewm"

src_compile() {
	econf --with-qt-dir=${QTDIR} || die
	emake || die
}

src_install() {
	einstall || die

	rm -rf ${D}/usr/doc

	dohtml icecc/docs/en/*.{html,sgml}
	dodoc AUTHORS COPYING README TODO
}
