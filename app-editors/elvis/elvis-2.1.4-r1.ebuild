# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/elvis/elvis-2.1.4-r1.ebuild,v 1.14 2003/06/12 14:34:57 agriffis Exp $

IUSE="X"

MY_P="${PN}-2.1_4"
S=${WORKDIR}/${MY_P}
DESCRIPTION="A vi/ex clone"
SRC_URI="ftp://ftp.cs.pdx.edu/pub/${PN}/${MY_P}.tar.gz"
HOMEPAGE="ftp://ftp.cs.pdx.edu/pub/elvis/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ppc sparc alpha"

DEPEND=">=sys-libs/ncurses-5.2
	X? ( virtual/x11 )"

PROVIDE="virtual/editor"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Fix bug 20864 using patch from FreeBSD port.
	# http://www.freshports.org/editors/elvis/
	epatch ${FILESDIR}/elvis-2.1.4-keysym.patch || die "epatch failed"
}

src_compile() {
	local myconf
	use X \
		&& myconf="--with-x" \
		|| myconf="--without-x"

	./configure \
		--bindir=${D}/usr/bin \
		--datadir=${D}/usr/share/elvis \
		${myconf} || die

	cp Makefile Makefile.orig
	sed -e "s:gcc -O2:gcc ${CFLAGS}:" Makefile.orig > Makefile
	cp config.h config.h.orig
	sed -e "s:${D}/usr/share/elvis:/usr/share/elvis:" config.h.orig > config.h
	make || die
}

src_install() {
	cp instman.sh instman.sh.orig
	sed -e "s:/usr/man:${D}/usr/share/man:g" instman.sh.orig > instman.sh

	cp insticon.sh insticon.sh.orig
	sed -e "s:^xinc=.*$:xinc=${D}/usr/include:" \
	 -e "s:^xlib=.*$:xlib=${D}/usr/lib:" \
		insticon.sh.orig > insticon.sh

	dodir /usr/bin
	dodir /usr/share/man/man1
	make install || die
}
