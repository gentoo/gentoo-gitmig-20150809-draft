# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-misc/icecc/icecc-0.5.ebuild,v 1.3 2002/08/02 17:54:50 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="IceWM Control-Center."
SRC_URI="http://www.selena.kherson.ua/xvadim/${P}.tar.bz2"
HOMEPAGE="http://www.selena.kherson.ua/xvadim"

DEPEND="virtual/x11
	x11-libs/qt"

RDEPEND="x11-wm/icewm"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile () {
	econf \
		--with-qt-dir=${QTDIR} || die
	emake || die
}

src_install () {
	einstall || die
	
	rm -rf ${D}/usr/doc

	dohtml icecc/docs/en/*.{html,sgml}
	dodoc AUTHORS COPYING README TODO
}
