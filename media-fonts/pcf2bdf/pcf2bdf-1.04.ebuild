# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/pcf2bdf/pcf2bdf-1.04.ebuild,v 1.5 2006/01/10 18:44:47 hansmi Exp $

inherit toolchain-funcs

DESCRIPTION="Converts PCF fonts to BDF fonts"
HOMEPAGE="http://www.tsg.ne.jp/GANA/S/pcf2bdf/"
SRC_URI="http://www.tsg.ne.jp/GANA/S/pcf2bdf/${P}.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~hppa ~ppc x86"

IUSE=""

DEPEND="virtual/libc"
S=${WORKDIR}

src_compile() {
	emake -f Makefile.gcc CC="$(tc-getCXX)" CFLAGS="${CXXFLAGS}" || die "emake failed"
}

src_install() {
	make -f Makefile.gcc \
		PREFIX=${D}/usr \
		MANPATH=${D}/usr/share/man/man1 \
		install || die
}
