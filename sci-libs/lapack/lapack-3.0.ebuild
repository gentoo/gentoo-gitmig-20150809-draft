# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/lapack/lapack-3.0.ebuild,v 1.3 2005/01/05 16:18:55 phosphan Exp $

DESCRIPTION="Linear Algebra PACKage for scientists, engineers, and mathematicians. This contains the libraries for creating programs that use LAPACK."
HOMEPAGE="http://www.netlib.org/lapack/"
SRC_URI="http://www.netlib.org/lapack/lapack.tgz"

LICENSE="lapack"
SLOT="0"
IUSE=""
KEYWORDS="x86 amd64 ~ppc"

DEPEND="virtual/libc
	sci-libs/blas"

S=${WORKDIR}/LAPACK

src_compile() {
	cp ${FILESDIR}/Makefile SRC/Makefile
	cd SRC
	FC="g77" FFLAGS="${CFLAGS}" make static || die "make failed"
}

src_install() {
	dolib.a SRC/liblapack.a || die "dolib failed"
}
