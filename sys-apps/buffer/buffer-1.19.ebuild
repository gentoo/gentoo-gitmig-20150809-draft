# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/buffer/buffer-1.19.ebuild,v 1.7 2004/06/29 15:21:26 vapier Exp $

DESCRIPTION="a tapedrive tool for speeding up rewinding of tape"
HOMEPAGE="http://www.microwerks.net/~hugo/download.html"
SRC_URI="http://www.microwerks.net/~hugo/download/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND="virtual/libc"
RDEPEND=""

src_compile() {
	make clean
	emake || die "make failed"
}

src_install() {
	dobin buffer || die
	dodoc README
}
