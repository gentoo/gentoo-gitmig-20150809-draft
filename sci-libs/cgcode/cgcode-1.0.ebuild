# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/cgcode/cgcode-1.0.ebuild,v 1.1 2010/10/31 10:37:29 jlec Exp $

EAPI="3"

inherit eutils fortran

FORTRNC="ifort gfortran"

DESCRIPTION="Conjugate gradient Codes for large sparse linear systems"
HOMEPAGE="http://fetk.org/codes/cgcode/index.html"
SRC_URI="http://www.fetk.org/codes/download/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
IUSE=""

RDEPEND="virtual/blas"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${PV}-gentoo.patch

	cat >> make.inc <<- EOF
	F77 = ${FORTRANC}
	FFLAGS = ${FFLAGS}
	BLASLIBS = $(pkg-config --libs blas)
	EOF
}

src_install() {
	dobin goos good || die
	dolib.so lib${PN}.so* || die
	dodoc INTRODUCTION NOTE README || die
}
