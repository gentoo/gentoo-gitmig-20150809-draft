# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# Author: Thilo Bangert <bangert@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.3 2002/02/04 15:46:51 gbevin Exp

S=${WORKDIR}/${P}

DESCRIPTION="reimplement libdjb - excellent libraries from Dan Bernstein."
SRC_URI="http://www.fefe.de/libowfat/${P}.tar.bz2"
HOMEPAGE="http://www.fefe.de/libowfat/"

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
