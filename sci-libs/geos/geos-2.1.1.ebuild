# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/geos/geos-2.1.1.ebuild,v 1.2 2005/05/14 04:19:22 matsuu Exp $

DESCRIPTION="Geometry Engine - Open Source"
HOMEPAGE="http://geos.refractions.net"
SRC_URI="http://geos.refractions.net/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static doc"

DEPEND="doc? ( app-doc/doxygen)"
RDEPEND="virtual/libc"

src_compile(){
	econf \
		$(use_enable static) \
		--prefix=/usr \
		|| die "Error: econf failed"
	emake || die "Error: emake failed"
}

src_install(){
	into /usr
	einstall
	dodoc AUTHORS COPYING INSTALL NEWS README TODO
	if use doc; then
		cd ${S}/doc
		make doxygen-html
		dohtml -r doxygen_docs/html/*
	fi
}

src_test() {
	cd ${S}
	make check || die "Tring make check without success."
}
