# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/bglibs/bglibs-1.041.ebuild,v 1.1 2006/04/22 05:16:38 robbat2 Exp $

inherit fixheadtails toolchain-funcs

DESCRIPTION="Bruce Guenters Libraries Collection"
HOMEPAGE="http://untroubled.org/bglibs/"
SRC_URI="http://untroubled.org/bglibs/archive/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~sparc ~x86"
IUSE=""
DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	# disable tests as we want them manually
	sed -e '/^all:/s|selftests||' -i.orig ${S}/Makefile
	sed -e '/selftests/d' -i.orig ${S}/TARGETS
}

src_compile() {
	echo "${D}/usr/bin" > conf-bin
	echo "${D}/usr/lib/bglibs" > conf-lib
	echo "${D}/usr/include/bglibs" > conf-include
	echo "${D}/usr/share/man" > conf-man
	echo "$(tc-getCC) ${CFLAGS}" > conf-cc
	echo "$(tc-getCC) ${LDFLAGS}" > conf-ld
	emake || die
}

src_test() {
	einfo "Running selftests"
	emake selftests
}

src_install () {
	einstall || die "install failed"

	#make backwards compatible symlinks
	dosym /usr/lib/bglibs /usr/lib/bglibs/lib
	dosym /usr/include/bglibs /usr/lib/bglibs/include

	dodoc ANNOUNCEMENT NEWS README ChangeLog TODO VERSION
	dohtml doc/html/*
	docinto latex
	dodoc doc/latex/*
}
