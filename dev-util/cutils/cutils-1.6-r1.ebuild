# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cutils/cutils-1.6-r1.ebuild,v 1.6 2004/11/06 15:52:46 pyrania Exp $

DESCRIPTION="C language utilities"
HOMEPAGE="http://www.sigala.it/sandro/software.html#cutils"
SRC_URI="http://www.sigala.it/sandro/files/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 sparc"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack  ${A}
	epatch ${FILESDIR}/${P}-gentoo.diff || die "epatch failed."
}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=${DESTTREE} \
		--infodir=${DESTTREE}/share/info \
		--mandir=${DESTTREE}/share/man || die

	emake -j1 || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc COPYRIGHT CREDITS HISTORY INSTALL NEWS README
}
