# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/pcf2bdf/pcf2bdf-1.04.ebuild,v 1.1 2004/05/15 17:53:47 usata Exp $

inherit gcc

DESCRIPTION="Converts PCF fonts to BDF fonts"
HOMEPAGE="http://www.tsg.ne.jp/GANA/S/pcf2bdf/"
SRC_URI="http://www.tsg.ne.jp/GANA/S/pcf2bdf/${P}.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND="virtual/glibc"
S=${WORKDIR}

src_compile() {
	emake -f Makefile.gcc CC=$(gcc-getCXX) || die "emake failed"
}

src_install() {
	make -f Makefile.gcc \
		PREFIX=${D}/usr \
		MANPATH=${D}/usr/share/man/man1 \
		install || die
}
