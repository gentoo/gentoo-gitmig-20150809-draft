# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/blas/blas-19980702-r1.ebuild,v 1.4 2004/09/02 02:36:26 tgall Exp $

DESCRIPTION="Basic Linear Algebra Subprograms"
HOMEPAGE="http://www.netlib.org/blas/"
SRC_URI="http://www.netlib.org/blas/${PN}.tgz"

LICENSE="public-domain"
IUSE=""
SLOT="0"
KEYWORDS="-* amd64 ~ppc64"

DEPEND="virtual/libc"

S=${WORKDIR}

src_compile() {
	cp ${FILESDIR}/Makefile ./
	# ncessary on amd64 to make libblas.a linkable
	use amd64 && CFLAGS="${CFLAGS} -fPIC"
	FC="g77" FFLAGS="${CFLAGS}" make static
}

src_install() {
	dolib.a libblas.a
}
