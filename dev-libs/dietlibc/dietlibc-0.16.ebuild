# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dietlibc/dietlibc-0.16.ebuild,v 1.5 2002/08/14 11:52:27 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A minimal libc"
SRC_URI="http://www.fefe.de/dietlibc/${P}.tar.bz2"
HOMEPAGE="http://www.fefe.de/dietlibc"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

src_unpack() {
	unpack ${A} ; cd ${S}
	mv Makefile Makefile.orig

	sed -e "s:^CFLAGS.*:CFLAGS = ${CFLAGS}:" \
		-e "s:^prefix.*:prefix=/usr/diet:" \
		-e "s:^#DESTDIR=/tmp/fef.*:DESTDIR=${D}:" \
		Makefile.orig > Makefile
	# does not say anything about this in the install docs - uncommenting (Thilo)
	#mkdir ${S}/include/asm
	#cp /usr/include/asm/posix_types.h ${S}/include/asm
}


src_compile() {
	emake || die
}

src_install () {

	make install || die

	exeinto /usr/bin
	newexe bin-i386/diet-i diet

	doman diet.1
	dodoc AUTHOR BUGS CAVEAT CHANGES README THANKS TODO PORTING
}
