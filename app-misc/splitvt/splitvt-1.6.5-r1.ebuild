# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/splitvt/splitvt-1.6.5-r1.ebuild,v 1.4 2005/03/26 00:00:14 hansmi Exp $

inherit eutils

MY_P="${P/-/_}"
DEB_PL="6"

DESCRIPTION="A program for splitting terminals into two shells"
HOMEPAGE="http://www.devolution.com/~slouken/projects/splitvt"
SRC_URI="http://www.devolution.com/~slouken/projects/${PN}/${P}.tar.gz
	mirror://debian/pool/main/s/splitvt/${MY_P}-${DEB_PL}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ppc"
IUSE=""

DEPEND=">=sys-libs/ncurses-5.2"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${MY_P}-${DEB_PL}.diff
	sed -i "s:/usr/local/bin:${D}/usr/bin:g" config.c
}

src_compile() {
	# upstream has their own weirdo configure script...
	./configure || die "configure failed"
	sed -i -e "s:-O2:${CFLAGS}:" Makefile
	emake || die "emake failed"
}

src_install() {
	dodir /usr/bin
	make install || die "make install failed"
	dodoc ANNOUNCE BLURB CHANGES NOTES README TODO
	doman splitvt.1
}
