# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/elvis/elvis-2.1.4.ebuild,v 1.15 2004/03/13 23:00:56 mr_bones_ Exp $

MY_P="${PN}-2.1_4"
S=${WORKDIR}/${MY_P}
DESCRIPTION="A vi/ex clone"
HOMEPAGE="ftp://ftp.cs.pdx.edu/pub/elvis/"
SRC_URI="ftp://ftp.cs.pdx.edu/pub/elvis/${MY_P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE="X"

DEPEND=">=sys-libs/ncurses-5.2
	X? ( virtual/x11 )"
PROVIDE="virtual/editor"

src_compile() {
	local myconf
	use X \
		&& myconf="--with-x" \
		|| myconf="--without-x"
	./configure \
		--bindir=${D}/usr/bin \
		--datadir=${D}/usr/share/elvis \
		${myconf} || die

	sed -i -e "s:gcc -O2:gcc ${CFLAGS}:" Makefile
	make || die
}

src_install() {
	sed -i -e "s:/usr/man:${D}/usr/share/man:g" instman.sh

	sed -i -e "s:^xinc=.*$:xinc=${D}/usr/include:" \
	 -e "s:^xlib=.*$:xlib=${D}/usr/lib:" \
		insticon.sh

	dodir /usr/bin
	dodir /usr/share/man/man1
	make install || die
}
