# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/frobby/frobby-0.8.2-r1.ebuild,v 1.2 2010/11/07 22:50:09 tomka Exp $

EAPI=2

inherit eutils

DESCRIPTION="Frobby is a software system and project for computations with monomial ideals"
HOMEPAGE="http://www.broune.com/frobby/"
SRC_URI="http://www.broune.com/frobby/frobby_v${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="dev-libs/gmp[-nocxx]
		doc? ( virtual/latex-base )"
RDEPEND="dev-libs/gmp[-nocxx]"

S="${WORKDIR}/frobby_v${PV}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-latex.patch"
	epatch "${FILESDIR}/${PN}-useless-checks.patch"
	epatch "${FILESDIR}/${PN}-cflags-no-strip.patch"
}

src_compile() {
	emake || die "compile failed"
	emake library || die "making libfrobby failed"
	if use doc; then
		# latex loops don't parallelize well
		emake -j1 doc || die "failed creating documentation"
	fi
}

src_install() {
	dobin bin/frobby || die
	dolib.a bin/libfrobby.a || die
	insinto /usr/include
	doins src/frobby.h || die
	dodir /usr/include/"${PN}" || die
	insinto /usr/include/"${PN}"
	doins src/stdinc.h || die
	if use doc; then
		dodoc bin/manual.pdf || die
	fi
}
