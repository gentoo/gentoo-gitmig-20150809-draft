# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/frobby/frobby-0.9.0.ebuild,v 1.1 2012/04/13 16:30:07 tomka Exp $

EAPI=4

inherit eutils

DESCRIPTION="Frobby is a software system and project for computations with monomial ideals"
HOMEPAGE="http://www.broune.com/frobby/"
SRC_URI="http://www.broune.com/frobby/frobby_v${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="dev-libs/gmp[cxx]"
DEPEND="${RDEPEND}
	doc? ( virtual/latex-base )"

S="${WORKDIR}/frobby_v${PV}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-cflags-no-strip.patch"
}

src_compile() {
	emake
	emake library
	if use doc; then
		# latex loops don't parallelize well
		emake -j1 doc
	fi
}

src_install() {
	dobin bin/frobby
	dolib.a bin/libfrobby.a
	insinto /usr/include
	doins src/frobby.h
	dodir /usr/include/"${PN}"
	insinto /usr/include/"${PN}"
	doins src/stdinc.h
	if use doc; then
		dodoc bin/manual.pdf
	fi
}
