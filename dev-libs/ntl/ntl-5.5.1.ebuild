# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ntl/ntl-5.5.1.ebuild,v 1.1 2009/08/10 23:22:39 bicatali Exp $

EAPI=2
inherit toolchain-funcs eutils

DESCRIPTION="High-performance and portable Number Theory C++ library"
HOMEPAGE="http://shoup.net/ntl/"
SRC_URI="http://www.shoup.net/ntl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc +gf2x +gmp"

RDEPEND="gmp? ( >=dev-libs/gmp-4.3 )
	gf2x? ( >=dev-libs/gf2x-0.9 )"
DEPEND="${RDEPEND}
	dev-lang/perl"

S="${WORKDIR}/${P}/src"

src_prepare() {
	cd ..
	# enable compatibility with singular
	epatch "$FILESDIR/${P}-singular.patch"
	# implement a call back framework ( submitted upstream)
	epatch "$FILESDIR/${P}-sage-tools.patch"
	# sanitize the makefile and allow the building of shared library
	epatch "$FILESDIR/${P}-shared.patch"
	cp "${FILESDIR}/linux.mk" src/
}

src_configure() {
	local myconf
	use gmp  && myconf="${myconf} NTL_GMP_LIP=on"
	use gf2x && myconf="${myconf} NTL_GF2X_LIB=on"
	perl DoConfig \
		PREFIX=/usr \
		${myconf} \
		CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}" \
		CC="$(tc-getCC)" CXX="$(tc-getCXX)" \
		AR="$(tc-getAR)" RANLIB="$(tc-getRANLIB)" \
		NTL_STD_CXX=on SHMAKE=linux \
		|| die "DoConfig failed"
}

src_compile() {
	# scripts convoluted in makefile make it hard to parallel make
	emake -j1 || die "emake failed"
	emake shared || die "emake shared failed"
}

src_install() {
	newlib.a ntl.a libntl.a || die "installation of static library failed"
	dolib.so lib*.so || die "installation of shared library failed"

	cd ..
	insinto /usr/include
	doins -r include/NTL || die "installation of the headers failed"

	dodoc README
	if use doc ; then
		dodoc doc/*.txt
		dohtml doc/*
	fi
}
