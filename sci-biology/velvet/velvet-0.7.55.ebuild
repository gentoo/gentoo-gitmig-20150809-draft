# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/velvet/velvet-0.7.55.ebuild,v 1.4 2009/10/31 17:57:32 maekke Exp $

EAPI="2"

MY_P="${PN}_${PV}"

DESCRIPTION="A sequence assembler for very short reads"
HOMEPAGE="http://www.ebi.ac.uk/~zerbino/velvet/"
SRC_URI="http://www.ebi.ac.uk/~zerbino/velvet/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
IUSE="-doc"
KEYWORDS="amd64 x86"

DEPEND="doc? ( virtual/latex-base )"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_prepare() {
	rm -rf "${S}"/third-party/zlib*
	sed -i -e '/\(CFLAGS\|LDFLAGS\|Z_LIB_DIR\|Z_LIB_FILES\) *= */d' \
		-e '1 a CFLAGS+= -Wall' -e '1 a LDFLAGS+= -lm -lz' \
		-e '/default :/ s/zlib//' -e '/color :/ s/zlib//' \
		"${S}"/Makefile || die
	use doc || sed -i -e '/default :/ s/doc//' "${S}"/Makefile || die
	sed -i -e '/zlib.h/d' -e '1 i #include <zlib.h>' "${S}"/src/readSet.c || die
}

src_compile() {
	MAKE_XOPTS=""
	if [[ $VELVET_MAXKMERLENGTH != "" ]]; then MAKE_XOPTS="$MAKE_XOPTS MAXKMERLENGTH=$VELVET_MAXKMERLENGTH"; fi
	if [[ $VELVET_CATEGORIES != "" ]]; then MAKE_XOPTS="$MAKE_XOPTS CATEGORIES=$VELVET_CATEGORIES"; fi
	emake -j1 $MAKE_XOPTS || die
	emake -j1 $MAKE_XOPTS color || die
}

src_install() {
	dobin velvet{g,h,g_de,h_de} || die
	insinto /usr/share/${PN}
	doins -r contrib || die
	dodoc Manual.pdf CREDITS.txt
}

pkg_postinst() {
	elog "To adjust the MAXKMERLENGTH or CATEGORIES parameters as described in the manual,"
	elog "please set the variables VELVET_MAXKMERLENGTH or VELVET_CATEGORIES in your"
	elog "environment or /etc/make.conf, then re-emerge the package. For example:"
	elog "	VELVET_MAXKMERLENGTH=NN emerge [options] velvet"
}
