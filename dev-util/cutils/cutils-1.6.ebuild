# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cutils/cutils-1.6.ebuild,v 1.1 2002/08/03 04:19:45 george Exp $

S=${WORKDIR}/${P}
DESCRIPTION="C language utilities"
HOMEPAGE="http://www.sigala.it/sandro/software.html#cutils"
SRC_URI="http://www.sigala.it/sandro/files/${P}.tar.gz"

SLOT="0"
KEYWORDS="x86"
LICENSE="as-is"

DEPEND="virtual/glibc"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack  ${A}
	patch -p0 <${FILESDIR}/${PF}-gentoo.diff || die
}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=${DESTTREE} \
		--infodir=${DESTTREE}/share/info \
		--mandir=${DESTTREE}/share/man || die
    
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc COPYRIGHT CREDITS HISTORY INSTALL NEWS README
}
