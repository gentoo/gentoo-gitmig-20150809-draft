# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Leigh Dyer <lsd@linuxgamers.net>
# $Header: /var/cvsroot/gentoo-x86/x11-libs/ecore/ecore-0.0.2.ebuild,v 1.1 2002/04/20 18:26:23 sandymac Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Convenience library for Xlib from the enlightenment project"
SRC_URI="http://prdownloads.sourceforge.net/enlightenment/${P}.tar.gz"
HOMEPAGE="http://www.enlightenment.org"

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
