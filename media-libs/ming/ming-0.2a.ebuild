# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/ming/ming-0.2a.ebuild,v 1.31 2010/04/21 16:32:51 mabi Exp $

inherit eutils toolchain-funcs multilib

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"

DESCRIPTION="An Open Source library for Flash movie generation."
HOMEPAGE="http://www.opaque.net/ming/"
SRC_URI="http://www.opaque.net/ming/${P}.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-fpic.patch"
	epatch "${FILESDIR}/${P}-gentoo.diff"
}

src_compile() {
	cd "${S}"
	make CC="$(tc-getCC) -Wall" all static || die "make failed"
	cd util
	make CC="$(tc-getCC) -Wall" bindump hexdump listswf listfdb listmp3 listjpeg makefdb swftophp || die "make utils failed"
}

src_install() {
	dolib.so libming.so || die "dolib.so libming.so failed"
	dolib.a libming.a || die "dolib.a libming.a failed"

	insinto /usr/include
	doins ming.h || die "doins ming.h failed"

	exeinto /usr/$(get_libdir)/ming
	doexe util/{bindump,hexdump,listswf,listfdb,listmp3,listjpeg,makefdb,swftophp} || die "doexe utils failed"

	dodoc CHANGES CREDITS README TODO
	newdoc util/README README.util
	newdoc util/TODO TODO.util
}
