# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/blas/blas-19980702-r1.ebuild,v 1.2 2005/09/10 08:47:21 pbienst Exp $

inherit fortran

DESCRIPTION="Basic Linear Algebra Subprograms"
HOMEPAGE="http://www.netlib.org/blas/"
SRC_URI="http://www.netlib.org/blas/${PN}.tgz"

LICENSE="public-domain"
IUSE=""
SLOT="0"
KEYWORDS="-* amd64 ~ppc64"

DEPEND="virtual/libc"

S=${WORKDIR}
FORTRAN="g77"

src_compile() {
	cp ${FILESDIR}/Makefile ./
	# ncessary on amd64 to make libblas.a linkable
	use amd64 && CFLAGS="${CFLAGS} -fPIC"
	FC="g77" FFLAGS="${CFLAGS}" make static
}

src_install() {
	dolib.a libblas.a
}
