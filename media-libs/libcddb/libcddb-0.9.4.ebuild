# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libcddb/libcddb-0.9.4.ebuild,v 1.10 2004/09/07 22:20:02 vapier Exp $

DESCRIPTION="A library for accessing a CDDB server"
HOMEPAGE="http://libcddb.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ppc ~sparc x86"
IUSE="doc"

DEPEND=">=dev-libs/libcdio-0.5
	doc? ( app-doc/doxygen )"

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
