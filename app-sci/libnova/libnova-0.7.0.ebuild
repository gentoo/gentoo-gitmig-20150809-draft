# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/libnova/libnova-0.7.0.ebuild,v 1.1 2003/05/21 07:08:35 mkennedy Exp $

DESCRIPTION="Celestial Mechanics and Astronomical Calculation Library"
HOMEPAGE="http://libnova.sourceforge.net/"
SRC_URI="mirror://sourceforge/libnova/${P}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="app-doc/doxygen"
RDEPEND=""

S=${WORKDIR}/${P}

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
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
}
