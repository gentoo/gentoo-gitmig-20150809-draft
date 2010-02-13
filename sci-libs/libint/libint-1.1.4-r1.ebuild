# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libint/libint-1.1.4-r1.ebuild,v 1.1 2010/02/13 18:27:00 jlec Exp $

EAPI="3"

inherit eutils toolchain-funcs

DESCRIPTION="Used to evaluate traditional and novel two-body matrix elements (integrals) over Cartesian Gaussian functions"
HOMEPAGE="http://www.chem.vt.edu/chem-dept/valeev/software/libint/libint.html"
SRC_URI="http://www.chem.vt.edu/chem-dept/valeev/software/libint/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
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
