# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/bglibs/bglibs-1.019-r1.ebuild,v 1.8 2006/02/20 21:21:59 hansmi Exp $

inherit fixheadtails toolchain-funcs

DESCRIPTION="Bruce Guenters Libraries Collection"
HOMEPAGE="http://untroubled.org/bglibs/"
SRC_URI="http://untroubled.org/bglibs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa mips ppc sparc x86"
IUSE=""
DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	# disable tests as we want them manually
	sed -e '/^all:/s|selftests||' -i.orig ${S}/Makefile
	sed -e '/selftests/d' -i.orig ${S}/TARGETS
}

src_compile() {
	echo "${D}/usr/lib/bglibs" > conf-home
	echo "$(tc-getCC) ${CFLAGS}" > conf-cc
	echo "$(tc-getCC) ${LDFLAGS}" > conf-ld
	# parallel builds fail badly
	emake -j1 || die
}

src_test() {
	einfo "Running selftests"
	emake -j1 selftests
}

src_install () {
	dodir /usr/lib/bglibs
	./installer || die "install failed"

	#move suff
	dodir /usr/include
	mv ${D}/usr/lib/bglibs/include ${D}/usr/include/bglibs
	mv ${D}/usr/lib/bglibs/lib/* ${D}/usr/lib/bglibs
	rmdir ${D}/usr/lib/bglibs/lib

	#make backwards compatible symlinks
	dosym /usr/lib/bglibs /usr/lib/bglibs/lib
	dosym /usr/include/bglibs /usr/lib/bglibs/include

	dodoc ANNOUNCEMENT NEWS README ChangeLog TODO VERSION
	dohtml doc/html/*
	docinto latex
	dodoc doc/latex/*
}
