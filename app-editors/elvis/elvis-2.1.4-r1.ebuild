# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-editors/elvis/elvis-2.1.4-r1.ebuild,v 1.7 2002/08/14 18:36:00 murphy Exp $

S=${WORKDIR}/elvis-2.1_4
DESCRIPTION="A vi/ex clone"
SRC_URI="ftp://ftp.cs.pdx.edu/pub/${PN}/${PN}-2.1_4.tar.gz"
HOMEPAGE="ftp://ftp.cs.pdx.edu/pub/elvis/"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2
	X? ( virtual/x11 )"
RDEPEND=""

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ppc sparc sparc64"

src_compile() {

	local myconf
	if [ "`use X`" ]; then
	myconf="--with-x"
	else
	myconf="--without-x"
	fi
	./configure --bindir=${D}/usr/bin --datadir=${D}/usr/share/elvis ${myconf} || die
	cp Makefile Makefile.orig
	sed -e "s:gcc -O2:gcc ${CFLAGS}:" Makefile.orig > Makefile
	cp config.h config.h.orig
	sed -e "s:${D}/usr/share/elvis:/usr/share/elvis:" config.h.orig > config.h
	make || die

}

src_install () {

	cp instman.sh instman.sh.orig
	cat instman.sh.orig | sed -e "s:/usr/man:${D}/usr/share/man:g" > instman.sh
	cp insticon.sh insticon.sh.orig
	cat insticon.sh.orig | sed -e "s:^xinc=.*$:xinc=${D}/usr/include:" \
	| sed -e "s:^xlib=.*$:xlib=${D}/usr/lib:" > insticon.sh
	dodir /usr/bin
	dodir /usr/share/man/man1
	make install || die

}
