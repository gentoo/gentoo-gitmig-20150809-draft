# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-misc/icebgset/icebgset-0.5.ebuild,v 1.2 2002/06/11 14:25:04 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="IceWM background editor."
SRC_URI="http://www.selena.kherson.ua/xvadim/${P}.tar.bz2"
HOMEPAGE="http://www.selena.kherson.ua/xvadim"

DEPEND="virtual/x11
	x11-libs/qt
	media-libs/jpeg
	media-libs/libpng"

SLOT="0"
LICENSE="GPL-2"

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
