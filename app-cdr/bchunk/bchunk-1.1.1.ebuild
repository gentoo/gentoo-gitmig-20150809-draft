# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/bchunk/bchunk-1.1.1.ebuild,v 1.19 2005/05/30 18:03:13 pylon Exp $

inherit toolchain-funcs

DESCRIPTION="Converts bin/cue CD-images to iso+wav/cdr"
HOMEPAGE="http://hes.iki.fi/bchunk/"
SRC_URI="http://hes.iki.fi/bchunk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc ~amd64"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	$(tc-getCC) ${CFLAGS} -o bchunk bchunk.c || die
}

src_install() {
	dobin bchunk || die
	doman bchunk.1
	dodoc ${P}.lsm README
}
