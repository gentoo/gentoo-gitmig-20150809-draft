# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libnova/libnova-0.7.0.ebuild,v 1.2 2009/10/09 20:57:34 ssuominen Exp $

DESCRIPTION="Celestial Mechanics and Astronomical Calculation Library"
HOMEPAGE="http://libnova.sourceforge.net/"
SRC_URI="mirror://sourceforge/libnova/${P}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="app-doc/doxygen"
RDEPEND=""

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	make || die
	cd doc && make doc || die
}

src_install() {
	dodir /usr/share/aclocal
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		LIBNOVA_MACRO_DIR=${D}/usr/share/aclocal \
		install || die
	dohtml doc/html/*
	doman doc/man/*/*
	dodoc AUTHORS ChangeLog NEWS README
}
