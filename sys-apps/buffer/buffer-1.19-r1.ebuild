# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/buffer/buffer-1.19-r1.ebuild,v 1.7 2004/08/15 16:35:39 morfic Exp $

DESCRIPTION="a tapedrive tool for speeding up reading from and writing to tape"
HOMEPAGE="http://www.microwerks.net/~hugo/download.html"
SRC_URI="http://www.microwerks.net/~hugo/download/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	make clean
	sed -i "s:#ifndef __alpha::" buffer.c
	sed -i "s:extern char \*shmat();::" buffer.c
	sed -i "s:#endif /\* __alpha \*/::" buffer.c
	emake || die "make failed"
}

src_install() {
	dobin buffer || die
	dodoc README
	newman buffer.man buffer.1
}
