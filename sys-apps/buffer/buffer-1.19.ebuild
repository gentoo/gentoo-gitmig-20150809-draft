# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/buffer/buffer-1.19.ebuild,v 1.4 2003/06/21 21:19:39 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="a tapedrive tool for speeding up rewinding of tape"
SRC_URI="http://www.microwerks.net/~hugo/download/${P}.tgz"
HOMEPAGE="http://www.microwerks.net/~hugo/download.html"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"

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
