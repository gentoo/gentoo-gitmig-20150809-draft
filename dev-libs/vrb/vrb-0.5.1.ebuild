# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/vrb/vrb-0.5.1.ebuild,v 1.4 2009/08/06 02:11:05 vostorga Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Library for a virtual ring buffer"
HOMEPAGE="http://vrb.slashusr.org/"
SRC_URI="http://vrb.slashusr.org/download/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~sparc ~x86"
IUSE="static"
RESTRICT="strip"

DEPEND="virtual/libc"
RDEPEND="${DEPEND}"

src_compile() {
	epatch "${FILESDIR}"/${P}-configure.patch

	CC="$(tc-getCC)" ./configure --prefix=/usr || die "Configure failed!"
	make || die "Make failed!"
}

src_install() {
	insinto /usr/include
	doins build/include/vrb.h

	mkdir "${D}"usr/lib

	if use static ; then
		cp build/lib/libvrb.a* "${D}"usr/lib/
	fi

	cp build/lib/libvrb.so* "${D}"usr/lib/

	dobin build/bin/vbuf

	dodoc README
	doman vrb/man/man3/*.3
}
