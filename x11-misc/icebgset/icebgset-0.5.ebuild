# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/icebgset/icebgset-0.5.ebuild,v 1.8 2002/12/09 04:41:52 manson Exp $

S=${WORKDIR}/${P}
DESCRIPTION="IceWM background editor."
SRC_URI="http://www.selena.kherson.ua/xvadim/${P}.tar.bz2"
HOMEPAGE="http://www.selena.kherson.ua/xvadim"

DEPEND="virtual/x11
	x11-libs/qt
	media-libs/jpeg
	media-libs/libpng"

RDEPEND="x11-wm/icewm"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

src_compile () {
	econf \
		--with-qt-dir=${QTDIR} || die
	emake || die
}

src_install () {
	einstall || die

	rm -rf ${D}/usr/doc
	dohtml icebgset/docs/en/*.{html,sgml}

	dodoc AUTHORS COPYING README TODO
}
