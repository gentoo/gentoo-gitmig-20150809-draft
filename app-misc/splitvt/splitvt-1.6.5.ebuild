# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/splitvt/splitvt-1.6.5.ebuild,v 1.14 2004/03/17 22:14:10 aliz Exp $

SRC_URI="http://www.devolution.com/~slouken/projects/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.devolution.com/~slouken/projects/splitvt"
DESCRIPTION="A program for splitting terminals into two shells"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ppc ~amd64"

DEPEND=">=sys-libs/ncurses-5.2"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s:/usr/local/bin:${D}/usr/bin:g" config.c
}

src_compile() {
	./configure || die
	sed -i -e "s:-O2:${CFLAGS}:" Makefile
	make || die
}

src_install() {
	dodir /usr/bin
	make install || die
	dodoc ANNOUNCE BLURB CHANGES NOTES README TODO
	doman splitvt.1
}
