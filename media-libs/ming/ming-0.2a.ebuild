# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/ming/ming-0.2a.ebuild,v 1.20 2004/10/07 03:00:54 eradicator Exp $

inherit eutils

DESCRIPTION="A OpenSource library from flash movie generation"
HOMEPAGE="http://www.opaque.net/ming/"
SRC_URI="http://www.opaque.net/ming/${P}.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 s390 ppc64"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A} ; cd ${S}
	epatch ${FILESDIR}/${P}-fpic.patch
	epatch ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {
	make CC="gcc -Wall" all static || die
	cd util
	make CC="gcc -Wall" bindump hexdump listswf listfdb listmp3 listjpeg makefdb swftophp \
		|| die
}

src_install() {
	dolib.so libming.so
	dolib.a  libming.a
	insinto /usr/include
	doins ming.h
	exeinto /usr/$(get_libdir)/ming
	doexe util/{bindump,hexdump,listswf,listfdb,listmp3,listjpeg,makefdb,swftophp}
	dodoc CHANGES CREDITS README TODO
	newdoc util/README README.util
	newdoc util/TODO TODO.util
}
