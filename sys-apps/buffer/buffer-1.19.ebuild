# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/buffer/buffer-1.19.ebuild,v 1.3 2003/02/13 15:49:51 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="a tapedrive tool for speeding up rewinding of tape"
SRC_URI="http://www.microwerks.net/~hugo/download/${P}.tgz"
HOMEPAGE="http://www.microwerks.net/~hugo/download.html"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="sys-libs/glibc"

RDEPEND=""

src_compile() {
	make clean	
	emake || die "make failed"
}

src_install () {
	exeinto /usr/bin
	doexe buffer
	dodoc README
}
