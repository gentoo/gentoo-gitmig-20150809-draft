# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/nighthawk/nighthawk-2.2.ebuild,v 1.1 2003/09/10 19:29:16 vapier Exp $

DESCRIPTION="A tribute to one of the most playable and contagious games ever written- Paradroid by Andrew Braybrook"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/games/arcade/${P}-1.tar.gz"
HOMEPAGE="http://jsno.arafuraconnect.com.au/proj_linux/nighthawk.html"
LICENSE="GPL-2"
DEPEND="x11-base/xfree"
SLOT="0"
KEYWORDS="x86 ppc"

src_compile() {
	patch -p1 < ${FILESDIR}/nighthawk.patch || die
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die "emake failed"
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc COPYING INSTALL
}
