# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtecla/libtecla-1.6.0.ebuild,v 1.3 2004/07/02 04:50:04 eradicator Exp $

DESCRIPTION="Tecla command-line editing library"
HOMEPAGE="http://www.astro.caltech.edu/~mcs/tecla/"
SRC_URI="http://www.astro.caltech.edu/~mcs/tecla/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
DEPEND="virtual/libc"

S=${WORKDIR}/libtecla

src_compile() {
	econf || die
	make || die
}

src_install() {
	make install prefix=${D}/usr MANDIR=${D}/usr/share/man || die
	dodoc CHANGES INSTALL LICENSE.TERMS PORTING README RELEASE.NOTES
}
