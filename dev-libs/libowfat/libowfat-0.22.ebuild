# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libowfat/libowfat-0.22.ebuild,v 1.1 2005/04/04 19:02:14 hansmi Exp $

DESCRIPTION="reimplement libdjb - excellent libraries from Dan Bernstein."
SRC_URI="http://dl.fefe.de/${P}.tar.bz2"
HOMEPAGE="http://www.fefe.de/libowfat/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc"
IUSE=""
DEPEND=">=dev-libs/dietlibc-0.23
	>=sys-apps/sed-4"

RDEPEND=">=dev-libs/dietlibc-0.23"

src_unpack() {
	unpack ${A} ; cd ${S}
	sed -i -e "s:^CFLAGS.*:CFLAGS=-I. ${CFLAGS}:" \
		-e "s:^DIET.*:DIET=/usr/bin/diet -Os:" \
		-e "s:^prefix.*:prefix=/usr:" \
		-e "s:^INCLUDEDIR.*:INCLUDEDIR=\${prefix}/include/libowfat:" \
		GNUmakefile
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
