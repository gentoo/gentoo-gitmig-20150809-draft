# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/moldy/moldy-2.16e-r2.ebuild,v 1.1 2010/04/15 14:46:26 jlec Exp $

EAPI="3"

inherit eutils toolchain-funcs

DESCRIPTION="Program for performing molecular dynamics simulations."
HOMEPAGE="http://www.ccp5.ac.uk/moldy/moldy.html"
SRC_URI="ftp://ftp.earth.ox.ac.uk/pub/keith/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~x86-linux ~ppc-macos"
IUSE="doc examples"

DEPEND="doc? ( virtual/latex-base )"

S="${WORKDIR}"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-as-needed.patch
}

src_configure() {
	#Individuals may want to edit the OPT* variables below.
	#From the READ.ME:
	#You may need to  "hand-tune" compiler or optimization options,
	#which may be specified by setting the OPT and OPT2 environment
	#variables.  OPT2 is used to compile only the most performance-critical
	#modules and usually will select a very high level of optimization.
	#It should be safe to select an optimization which means "treat all
	#function arguments as restricted pointers which are not aliased to
	#any other object".  OPT is used for less preformance-critical modules
	#and may be set to a lower level of optimization than OPT2.

	OPT="${CFLAGS}" \
	OPT2="${CFLAGS} ${CFLAGS_OPT}" \
	CC=$(tc-getCC) \
	econf
}

src_compile() {
	emake || die
	# To prevent sandbox violations by metafont
	if use doc; then
		VARTEXFONTS="${T}"/fonts emake moldy.pdf || die
	fi
}

src_install() {
	dodir /usr/bin
	emake prefix="${ED}"/usr install || die
	dodoc BENCHMARK READ.ME RELNOTES || die

	if use examples; then
		rm Makefile.in configure.in config.h.in
		insinto /usr/share/${PN}/examples/
		doins *.in *.out control.* || die
	fi
	if use doc; then
		insinto /usr/share/doc/${PF}/pdf
		newins moldy.pdf moldy-manual.pdf
	fi
}
