# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/ming/ming-0.2a.ebuild,v 1.13 2004/01/11 03:54:38 agriffis Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A OpenSource library from flash movie generation"
SRC_URI="http://www.opaque.net/ming/${P}.tgz"
HOMEPAGE="http://www.opaque.net/ming/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 sparc hppa ppc amd64 alpha ia64"

DEPEND="virtual/glibc"

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

src_install () {
	dolib.so libming.so
	dolib.a  libming.a
	insinto /usr/include
	doins ming.h
	exeinto /usr/lib/ming
	doexe util/{bindump,hexdump,listswf,listfdb,listmp3,listjpeg,makefdb,swftophp}
	dodoc CHANGES CREDITS LICENSE README TODO
	newdoc util/README README.util
	newdoc util/TODO TODO.util
}
