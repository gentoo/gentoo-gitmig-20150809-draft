# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtecla/libtecla-1.6.1.ebuild,v 1.1 2006/01/20 17:49:57 markusle Exp $

DESCRIPTION="Tecla command-line editing library"
HOMEPAGE="http://www.astro.caltech.edu/~mcs/tecla/"
SRC_URI="http://www.astro.caltech.edu/~mcs/tecla/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc"

IUSE=""
DEPEND="virtual/libc
		sys-libs/ncurses"

S=${WORKDIR}/libtecla

src_compile() {
	# remove build directory from RPATH (see bug #119477)
	sed -e "s|:\$\$LD_RUN_PATH:\`pwd\`||" -i Makefile.rules || \
		die "Failed to adjust Makefile.rules"
	econf || die
	make || die
}

src_install() {
	make install prefix=${D}/usr MANDIR=${D}/usr/share/man || die
	dodoc CHANGES INSTALL LICENSE.TERMS PORTING README RELEASE.NOTES
}
