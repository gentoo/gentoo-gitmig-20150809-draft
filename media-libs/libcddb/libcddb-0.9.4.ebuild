# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libcddb/libcddb-0.9.4.ebuild,v 1.3 2004/01/13 20:25:55 mholzer Exp $

IUSE="doc"

DESCRIPTION="A library for accessing a CDDB server"
HOMEPAGE="http://libcddb.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"
LICENSE="LGPL-2"

DEPEND=">=dev-libs/libcdio-0.5
	    doc? ( app-doc/doxygen )"

SLOT="0"
KEYWORDS="x86 ~sparc"

src_compile() {
	econf || die
	emake || die

	# Create API docs if needed and possible
	use doc && cd doc; doxygen doxygen.conf
}

src_install() {
	make DESTDIR=${D} install

	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README THANKS TODO
	# Create API docs if needed and possible
	use doc && dohtml doc/html/*
}
