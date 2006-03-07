# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/ming/ming-0.2a.ebuild,v 1.24 2006/03/07 11:56:06 flameeyes Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A OpenSource library from flash movie generation"
HOMEPAGE="http://www.opaque.net/ming/"
SRC_URI="http://www.opaque.net/ming/${P}.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-fpic.patch
	epatch ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {
	make CC="$(tc-getCC) -Wall" all static || die
	cd util
	make CC="$(tc-getCC) -Wall" bindump hexdump listswf listfdb listmp3 listjpeg makefdb swftophp || die
}

src_install() {
	dolib.so libming.so || die "lib.so"
	dolib.a libming.a || die "lib.a"
	insinto /usr/include
	doins ming.h || die "include"
	exeinto /usr/$(get_libdir)/ming
	doexe util/{bindump,hexdump,listswf,listfdb,listmp3,listjpeg,makefdb,swftophp} || die "utils"
	dodoc CHANGES CREDITS README TODO
	newdoc util/README README.util
	newdoc util/TODO TODO.util
}
