# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-misc/icets/icets-0.8.ebuild,v 1.1 2002/06/11 15:14:07 seemant Exp $

MY_P=${P/./}
S=${WORKDIR}/${MY_P}
DESCRIPTION="IceWM Theme Editor."
SRC_URI="http://www.selena.kherson.ua/xvadim/${P}.tar.bz2"
HOMEPAGE="http://www.selena.kherson.ua/xvadim"

DEPEND="virtual/x11
	x11-libs/qt
	media-libs/jpeg
	media-libs/libpng"

#RDEPEND="x11-wm/icewm"

src_unpack() {

	unpack ${A}
	cd ${S}/${PN}

	# Change the default directory that it looks into to be consistent
	# with Gentoo's layout
	cp icets.cpp icets.cpp.orig
	sed "s:/usr/local/lib/X11/icewm/themes:/usr/lib/icewm/themes:" \
		icets.cpp.orig > icets.cpp
}

src_compile () {
	econf --with-qt-dir=${QTDIR} || die
	emake || die
}

src_install () {
	einstall || die
	
	rm -rf ${D}/usr/doc
	dohtml icets/docs/en/*.{html,sgml}
	dodoc AUTHORS COPYING ChangeLog README TODO
}
