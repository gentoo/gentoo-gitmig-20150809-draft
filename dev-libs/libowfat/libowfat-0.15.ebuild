# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libowfat/libowfat-0.15.ebuild,v 1.2 2004/03/23 19:03:19 dragonheart Exp $

DESCRIPTION="reimplement libdjb - excellent libraries from Dan Bernstein."
SRC_URI="http://www.fefe.de/libowfat/${P}.tar.bz2"
HOMEPAGE="http://www.fefe.de/libowfat/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ~ppc"
IUSE=""
DEPEND=">=dev-libs/dietlibc-0.16"

src_unpack() {
	unpack ${A} ; cd ${S}
	mv GNUmakefile GNUmakefile.orig
	sed -e "s:^CFLAGS.*:CFLAGS=-I. ${CFLAGS}:" \
		-e "s:^DIET.*:DIET=/usr/bin/diet -Os:" \
		-e "s:^prefix.*:prefix=/usr:" \
		-e "s:^INCLUDEDIR.*:INCLUDEDIR=\${prefix}/include/libowfat:" \
		GNUmakefile.orig > GNUmakefile
}

src_compile() {
	emake || die
}

src_install () {
	make \
		LIBDIR=${D}/usr/lib \
		MAN3DIR=${D}/usr/share/man/man3 \
		INCLUDEDIR=${D}/usr/include/libowfat \
		install || die
}
