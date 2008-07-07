# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libint/libint-1.1.4.ebuild,v 1.1 2008/07/07 06:38:17 dberkholz Exp $

inherit toolchain-funcs

DESCRIPTION="Used to evaluate traditional and novel two-body matrix elements (integrals) over Cartesian Gaussian functions"
HOMEPAGE="http://www.chem.vt.edu/chem-dept/valeev/software/libint/libint.html"
SRC_URI="http://www.chem.vt.edu/chem-dept/valeev/software/libint/src/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RDEPEND=""
DEPEND="${RDEPEND}"

src_compile() {
	econf \
		--enable-shared \
		--enable-deriv \
		--enable-r12 \
		--with-cc=$(tc-getCC) \
		--with-cxx=$(tc-getCXX) \
		--with-cc-optflags="${CFLAGS}" \
		--with-cxx-optflags="${CXXFLAGS}" \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die
}
