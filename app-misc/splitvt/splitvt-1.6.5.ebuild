# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/splitvt/splitvt-1.6.5.ebuild,v 1.5 2002/07/25 19:18:34 seemant Exp $

S=${WORKDIR}/${P}
SRC_URI="http://www.devolution.com/~slouken/projects/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.devolution.com/~slouken/projects/splitvt"
DESCRIPTION="A program for splitting terminals into two shells"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=sys-libs/ncurses-5.2"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp config.c config.orig
	cat config.orig | sed "s:/usr/local/bin:${D}/usr/bin:g" > config.c
}

src_compile() {
	./configure || die
	cp Makefile Makefile.orig
	sed -e "s:-O2:${CFLAGS}:" Makefile.orig > Makefile
	make || die
}

src_install() {
	dodir /usr/bin
	make install || die
	dodoc ANNOUNCE BLURB CHANGES NOTES README TODO
	doman splitvt.1
}
