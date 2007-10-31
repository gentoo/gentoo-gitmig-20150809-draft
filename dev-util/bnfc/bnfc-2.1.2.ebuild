# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bnfc/bnfc-2.1.2.ebuild,v 1.5 2007/10/31 13:19:47 dcoutts Exp $

DESCRIPTION="BNF Converter -- a sophisticated parser generator"
HOMEPAGE="http://www.cs.chalmers.se/~markus/BNFC/"
SRC_URI="http://www.cs.chalmers.se/~markus/BNFC/${PN}_${PV}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

IUSE="doc"

DEPEND=">=dev-lang/ghc-6.2
	!>=dev-lang/ghc-6.6
	doc? ( virtual/tetex )"

RDEPEND="virtual/libc"

S="${WORKDIR}/BNFC"

src_unpack() {
	unpack ${A}
}

src_compile() {
	emake GHC_OPTS=-O || die "emake failed"
}

src_install() {
	dobin bnfc
	if use doc ; then
		cd doc
		pdflatex LBNF-report.tex
		pdflatex LBNF-report.tex
		dodoc LBNF-report.pdf
	fi
}
