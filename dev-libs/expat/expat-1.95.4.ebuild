# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/expat/expat-1.95.4.ebuild,v 1.5 2002/09/01 18:48:36 george Exp $

S=${WORKDIR}/${P}
DESCRIPTION="XML parsing libraries"
SRC_URI="mirror://sourceforge/expat/${P}.tar.gz"
HOMEPAGE="http://expat.sourceforge.net"

DEPEND="virtual/glibc"
RDEPEND="${DEPEND}"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc sparc64"

src_compile() {
    ./configure \
		--prefix=/usr \
		--mandir=/usr/share/man/man1 || die "configure failed"

	# parallel make doesnt work
	make || die
}

src_install() {
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man/man1 install || die "make install failed"

	dodoc COPYING Changes MANIFEST README
	dohtml doc/*
}
