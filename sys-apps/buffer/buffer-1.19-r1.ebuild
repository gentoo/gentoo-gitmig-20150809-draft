# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/buffer/buffer-1.19-r1.ebuild,v 1.4 2003/09/07 00:51:33 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="a tapedrive tool for speeding up reading from and writing to tape"
SRC_URI="http://www.microwerks.net/~hugo/download/${P}.tgz"
HOMEPAGE="http://www.microwerks.net/~hugo/download.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64"

DEPEND="virtual/glibc"

src_compile() {
	make clean
	emake || die "make failed"
}

src_install () {
	exeinto /usr/bin
	doexe buffer
	dodoc README

	newman buffer.man buffer.1
}
