# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/bchunk/bchunk-1.1.1.ebuild,v 1.10 2002/12/09 04:17:37 manson Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Converts bin/cue CD-images to iso+wav/cdr"
SRC_URI="http://hes.iki.fi/bchunk/${P}.tar.gz"
HOMEPAGE="http://hes.iki.fi/bchunk/"
LICENSE="GPL-2"
DEPEND="virtual/glibc"
SLOT="0"
KEYWORDS="x86 ppc sparc "

src_compile() {
	gcc ${CFLAGS} -o bchunk bchunk.c
}

src_install() {
	dobin bchunk
	doman bchunk.1
	dodoc ${P}.lsm
	dodoc COPYING README
}
