# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/velvet/velvet-0.7.34.ebuild,v 1.1 2009/06/21 14:49:00 weaver Exp $

EAPI="2"

MY_P="${PN}_${PV}"

DESCRIPTION="A sequence assembler for very short reads"
HOMEPAGE="http://www.ebi.ac.uk/~zerbino/velvet/"
SRC_URI="http://www.ebi.ac.uk/~zerbino/velvet/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	rm -rf "${S}"/third-party/zlib*
	sed -i -e '/\(CFLAGS\|LDFLAGS\|Z_LIB_DIR\|Z_LIB_FILES\) *= */d' \
		-e '1 a CFLAGS+= -Wall' -e '1 a LDFLAGS+= -lm -lz' \
		-e '/default :/ s/zlib//' -e '/color :/ s/zlib//' \
		"${S}"/Makefile || die
	sed -i -e '/zlib.h/d' -e '1 i #include <zlib.h>' "${S}"/src/readSet.c || die
}

src_compile() {
	emake -j1 || die
	emake -j1 color || die
}

src_install() {
	dobin velvet{g,h,g_de,h_de} third-party/layout/graph2.py third-party/afg_handling/*.pl || die
	dodoc Manual.pdf CREDITS.txt
}
