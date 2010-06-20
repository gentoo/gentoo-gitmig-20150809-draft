# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/velvet/velvet-0.7.62.ebuild,v 1.2 2010/06/20 18:05:05 xarthisius Exp $

EAPI="2"

inherit eutils toolchain-funcs

MY_P=${PN}_${PV}

DESCRIPTION="A sequence assembler for very short reads"
HOMEPAGE="http://www.ebi.ac.uk/~zerbino/velvet/"
SRC_URI="http://www.ebi.ac.uk/~zerbino/velvet/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
IUSE="-doc"
KEYWORDS="~amd64 ~x86"

DEPEND="doc? ( virtual/latex-base )"
RDEPEND=""

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.diff
	use doc || sed -i -e '/default :/ s/doc//' "${S}"/Makefile || die
}

src_compile() {
	tc-export CC
	MAKE_XOPTS=""
	if [[ $VELVET_MAXKMERLENGTH != "" ]]; then MAKE_XOPTS="$MAKE_XOPTS MAXKMERLENGTH=$VELVET_MAXKMERLENGTH"; fi
	if [[ $VELVET_CATEGORIES != "" ]]; then MAKE_XOPTS="$MAKE_XOPTS CATEGORIES=$VELVET_CATEGORIES"; fi
	emake $MAKE_XOPTS || die
	emake $MAKE_XOPTS color || die
}

src_install() {
	dobin velvet{g,h,g_de,h_de} || die
	insinto /usr/share/${PN}
	doins -r contrib || die
	dodoc Manual.pdf CREDITS.txt ChangeLog || die
}

pkg_postinst() {
	elog "To adjust the MAXKMERLENGTH or CATEGORIES parameters as described in the manual,"
	elog "please set the variables VELVET_MAXKMERLENGTH or VELVET_CATEGORIES in your"
	elog "environment or /etc/make.conf, then re-emerge the package. For example:"
	elog "	VELVET_MAXKMERLENGTH=NN emerge [options] velvet"
}
