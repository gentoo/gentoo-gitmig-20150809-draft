# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/btparse/btparse-0.33.ebuild,v 1.11 2004/07/14 14:04:41 agriffis Exp $

DESCRIPTION="A C library to parse Bibtex files"
HOMEPAGE="http://starship.python.net/~gward/btOOL/"
SRC_URI="http://starship.python.net/~gward/btOOL//${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	#have to include ${D} into mandir here,
	#for some reason mandir=${D}/... is ignored during make install..
	./configure --host=${CHOST} \
		--prefix=/usr \
		--mandir=${D}/usr/share/man  || die "./configure failed"
	emake lib shlib || die
}

src_install () {
	#make \
	#	prefix=${D}/usr \
	#	mandir=${D}/usr/share/man \
	#	install || die


	make prefix=${D}/usr install || die
	dolib.so libbtparse.so
	dodoc CHANGES README
}
