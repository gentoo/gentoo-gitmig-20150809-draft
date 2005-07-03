# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/geos/geos-2.1.2.ebuild,v 1.1 2005/07/03 01:44:14 nakano Exp $

inherit eutils

DESCRIPTION="Geometry Engine - Open Source"
HOMEPAGE="http://geos.refractions.net/"
SRC_URI="http://geos.refractions.net/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE="static doc"

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

src_compile() {
	econf $(use_enable static) || die "Error: econf failed"
	emake || die "Error: emake failed"
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS INSTALL NEWS README TODO
	if use doc; then
		cd ${S}/doc
		make doxygen-html
		dohtml -r doxygen_docs/html/*
	fi
}

src_test() {
	make check || die "Tring make check without success."
}
