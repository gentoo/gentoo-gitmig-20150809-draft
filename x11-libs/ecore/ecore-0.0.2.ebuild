# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/ecore/ecore-0.0.2.ebuild,v 1.6 2002/10/04 06:38:37 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Convenience library for Xlib from the enlightenment project"
SRC_URI="mirror://sourceforge/enlightenment/${P}.tar.gz"
HOMEPAGE="http://www.enlightenment.org"
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

DEPEND="x11-base/xfree"

src_unpack() {
	unpack ${A}
	cd ${S}
	# This patch fixes a function prototype that breaks C++ compilation
	patch -p1 < ${FILESDIR}/${PVR}/ecore-0.0.2-cxxfix.patch || die
}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	
	dodoc README AUTHORS
}
