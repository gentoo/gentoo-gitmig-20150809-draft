# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/expat/expat-1.95.4.ebuild,v 1.18 2004/07/14 14:19:00 agriffis Exp $

DESCRIPTION="XML parsing libraries"
SRC_URI="mirror://sourceforge/expat/${P}.tar.gz"
HOMEPAGE="http://expat.sourceforge.net/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc alpha mips hppa"
IUSE=""

DEPEND="virtual/libc"

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
