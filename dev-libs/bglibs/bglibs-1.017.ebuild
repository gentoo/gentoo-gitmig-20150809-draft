# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/bglibs/bglibs-1.017.ebuild,v 1.5 2004/10/19 08:24:37 absinthe Exp $

inherit fixheadtails gcc

DESCRIPTION="Bruce Guenters Libraries Collection"
HOMEPAGE="http://untroubled.org/bglibs/"
SRC_URI="http://untroubled.org/bglibs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~mips alpha amd64 ~hppa"
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
	echo "$(gcc-getCC) ${CFLAGS}" > conf-cc
	echo "$(gcc-getCC) ${LDFLAGS}" > conf-ld
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
	dodoc ANNOUNCEMENT NEWS README ChangeLog TODO VERSION
	docinto html
	dodoc doc/html/*
	docinto latex
	dodoc doc/latex/*
}
