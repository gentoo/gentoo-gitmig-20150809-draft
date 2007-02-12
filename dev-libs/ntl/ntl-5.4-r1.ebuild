# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ntl/ntl-5.4-r1.ebuild,v 1.1 2007/02/12 22:14:20 dev-zero Exp $

inherit toolchain-funcs eutils

DESCRIPTION="A high-performance, portable C++ Library for doing Number Theory"
HOMEPAGE="http://shoup.net/ntl/"
SRC_URI="http://www.shoup.net/ntl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="doc gmp"

RDEPEND="gmp? ( >=dev-libs/gmp-4.1-r1 )"
DEPEND="${RDEPEND}
	dev-lang/perl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-endless_testrun.patch"
}

src_compile() {
	local myconf=""
	use gmp && myconf="${myconf} NTL_GMP_LIP=on"
	cd src
	perl DoConfig \
		PREFIX=/usr \
		${myconf} \
		CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}" \
		CC="$(tc-getCC)" CXX="$(tc-getCXX)" \
		AR="$(tc-getAR)" RANLIB="$(tc-getRANLIB)" \
		|| die "DoConfig failed"

	emake || die "emake failed"
}

src_install() {
	newlib.a src/ntl.a libntl.a
	insinto /usr/include
	doins -r include/NTL

	dodoc README

	if use doc ; then
		dodoc doc/*.txt
		dohtml doc/*.{html,gif}
	fi
}

src_test() {
	cd src
	emake check || die "emake check failed"
}
