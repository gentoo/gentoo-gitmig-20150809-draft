# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/lapack/lapack-3.0-r1.ebuild,v 1.1 2004/04/21 20:33:05 kugelfang Exp $

DESCRIPTION="Linear Algebra PACKage for scientists, engineers, and mathematicians. This contains the libraries for creating programs that use LAPACK."
HOMEPAGE="http://www.netlib.org/lapack/"
SRC_URI="http://www.netlib.org/lapack/lapack.tgz"

LICENSE="lapack"
SLOT="0"
IUSE=""
KEYWORDS="-* amd64"

DEPEND="virtual/glibc
	app-sci/blas"

S=${WORKDIR}/LAPACK

src_compile() {
	cp ${FILESDIR}/Makefile SRC/Makefile
	cd SRC
	# ncessary to be able to link against liblapack.a on amd64
	use amd64 && CFLAGS="${CFLAGS} -fPIC"
	FC="g77" FFLAGS="${CFLAGS}" make static
}

src_install() {
	dolib.a SRC/liblapack.a
}
