# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/icets/icets-1.0.ebuild,v 1.3 2003/05/19 14:03:31 phosphan Exp $

DESCRIPTION="IceWM Theme Editor"
SRC_URI="mirror://sourceforge/icecc/${P}.tar.bz2"
HOMEPAGE="http://icecc.sourceforge.net/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=qt-3.0.0"

src_unpack() {

	unpack ${A}
	cd ${S}/${PN}

	# Change the default directory that it looks into to be consistent
	# with Gentoo's layout
	cp icets.cpp icets.cpp.orig
	sed "s:/usr/local/share/icewm/themes:/usr/share/icewm/themes:" \
		icets.cpp.orig > icets.cpp
}

src_compile () {
	econf || die
	emake || die
}

src_install () {
	einstall || die
	
	rm -rf ${D}/usr/doc
	dohtml icets/docs/en/*.{html,sgml}
	dodoc AUTHORS COPYING ChangeLog README TODO
}
