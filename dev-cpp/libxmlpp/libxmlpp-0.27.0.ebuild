# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libxmlpp/libxmlpp-0.27.0.ebuild,v 1.8 2004/10/23 23:40:22 weeve Exp $

inherit libtool

MY_P=${P/pp/++}
DESCRIPTION="C++ wrapper for the libxml XML parser library"
HOMEPAGE="http://libxmlplusplus.sourceforge.net/"
SRC_URI="mirror://sourceforge/libxmlplusplus/${MY_P}.tar.gz"

IUSE=""
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~ppc sparc"

DEPEND=">=dev-libs/libxml2-2.5.1"

S=${WORKDIR}/${MY_P}
MAKEOPTS="${MAKEOPTS} -j1"

src_compile() {
	elibtoolize
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install|| die "Install failed"
#	dosym /usr/lib/libxml++-0.1.a /usr/lib/libxml++.a
#	dosym /usr/lib/libxml++-0.1.so /usr/lib/libxml++.so
	dodoc AUTHORS COPYING ChangeLog NEWS README*
}
