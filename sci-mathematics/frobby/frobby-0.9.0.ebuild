# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/frobby/frobby-0.9.0.ebuild,v 1.4 2012/05/18 16:32:13 tomka Exp $

EAPI=4

inherit eutils

DESCRIPTION="Frobby is a software system and project for computations with monomial ideals"
HOMEPAGE="http://www.broune.com/frobby/"
SRC_URI="http://www.broune.com/frobby/frobby_v${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc"

RDEPEND="dev-libs/gmp[cxx]"
DEPEND="${RDEPEND}
	doc? ( virtual/latex-base )"

S="${WORKDIR}/frobby_v${PV}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-cflags-no-strip.patch"
	# CXXFLAGS are called CPPFLAGS
	sed "s/CPPFLAGS/CXXFLAGS/" -i Makefile
}

src_compile() {
	# Makefile uses the value of CXX which may be defined in /etc/env,
	# breaking cross-compile.
	CXX=$(tc-getCXX) emake
	CXX=$(tc-getCXX) emake library
	if use doc; then
		emake docPdf
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
