# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cutils/cutils-1.6-r1.ebuild,v 1.4 2004/07/02 05:05:26 eradicator Exp $

IUSE=""

DESCRIPTION="C language utilities"
HOMEPAGE="http://www.sigala.it/sandro/software.html#cutils"
SRC_URI="http://www.sigala.it/sandro/files/${P}.tar.gz"

SLOT="0"
KEYWORDS="x86 sparc"
LICENSE="as-is"

DEPEND="virtual/libc"

src_unpack() {
	unpack  ${A}
	patch -p0 <${FILESDIR}/${P}-gentoo.diff || die
}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=${DESTTREE} \
		--infodir=${DESTTREE}/share/info \
		--mandir=${DESTTREE}/share/man || die

	MAKEOPTS=-j1 emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc COPYRIGHT CREDITS HISTORY INSTALL NEWS README
}
