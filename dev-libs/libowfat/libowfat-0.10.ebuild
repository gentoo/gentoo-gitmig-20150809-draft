# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libowfat/libowfat-0.10.ebuild,v 1.10 2004/03/23 19:03:19 dragonheart Exp $

DESCRIPTION="reimplement libdjb - excellent libraries from Dan Bernstein."
SRC_URI="http://www.fefe.de/libowfat/${P}.tar.bz2"
HOMEPAGE="http://www.fefe.de/libowfat/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"
IUSE=""
DEPEND=">=dev-libs/dietlibc-0.16"

src_unpack() {
	unpack ${A} ; cd ${S}
	mv Makefile Makefile.orig
	sed -e "s:^CFLAGS.*:CFLAGS=-I. ${CFLAGS}:" \
		-e "s:^DIET.*:DIET=/usr/bin/diet -Os:" \
		-e "s:^prefix.*:prefix=/usr:" \
		-e "s:^INCLUDEDIR.*:INCLUDEDIR=\${prefix}/include/libowfat:" \
		Makefile.orig > Makefile

	#patch Makefile to fix a bug in the install section
	#this has been submitted upstream and is fixed in cvs
	#ie. it should not be necessary for libowfat-0.11 and later
	patch -p0 < ${FILESDIR}/${PF}-gentoo.diff

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
