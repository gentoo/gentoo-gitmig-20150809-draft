# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-sci/blas/blas-19980702.ebuild,v 1.3 2003/02/13 09:21:08 vapier Exp $

SLOT="0"
HOMEPAGE="http://www.netlib.org/blas/"
DESCRIPTION="Basic Linear Algebra Subprograms"
SRC_URI="http://www.netlib.org/blas/${PN}.tgz"

DEPEND="virtual/glibc"
KEYWORDS="x86"
LICENSE="public-domain"
IUSE=""

S="${WORKDIR}"

src_compile() {
	cp ${FILESDIR}/Makefile ./
	FC="g77" FFLAGS="${CFLAGS}" make static
}

src_install() {
	dolib.a libblas.a
}
