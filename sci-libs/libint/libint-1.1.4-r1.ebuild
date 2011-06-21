# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libint/libint-1.1.4-r1.ebuild,v 1.2 2011/06/21 08:31:23 jlec Exp $

EAPI=3

inherit eutils fortran-2 toolchain-funcs

DESCRIPTION="Matrix elements (integrals) evaluation over Cartesian Gaussian functions"
HOMEPAGE="http://www.chem.vt.edu/chem-dept/valeev/software/libint/libint.html"
SRC_URI="http://www.chem.vt.edu/chem-dept/valeev/software/libint/src/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/1.1.4-as-needed.patch
}

src_configure() {
	econf \
		--enable-shared \
		--enable-deriv \
		--enable-r12 \
		--with-cc=$(tc-getCC) \
		--with-cxx=$(tc-getCXX) \
		--with-cc-optflags="${CFLAGS}" \
		--with-cxx-optflags="${CXXFLAGS}"
}

src_compile() {
	emake \
		LDFLAGS="${LDFLAGS}" \
		|| die
}

src_install() {
	einstall || die
}
