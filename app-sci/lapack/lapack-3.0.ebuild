# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-sci/lapack/lapack-3.0.ebuild,v 1.3 2003/02/13 09:23:06 vapier Exp $

S=${WORKDIR}/LAPACK

LICENSE="lapack"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DESCRIPTION="Linear Algebra PACKage for scientists, engineers, and mathematicians. This contains the libraries for creating programs that use LAPACK."

SRC_URI="http://www.netlib.org/lapack/lapack.tgz"
HOMEPAGE="http://www.netlib.org/lapack/"
DEPEND="virtual/glibc
	app-sci/blas"

src_compile() {
	cp ${FILESDIR}/Makefile SRC/Makefile
	cd SRC
	FC="g77" FFLAGS="${CFLAGS}" make static
}

src_install () {
	dolib.a SRC/liblapack.a
}
