# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-sci/octave/octave-2.1.36.ebuild,v 1.2 2002/09/19 20:09:39 owen Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GNU Octave is a high-level language (MatLab compatible) intended for numerical computations."
SRC_URI="ftp://ftp.octave.org/pub/octave/bleeding-edge/${P}.tar.bz2"
HOMEPAGE="http://www.octave.org/"

DEPEND="virtual/glibc
		>=sys-libs/ncurses-5.2-r3
		>=media-gfx/gnuplot-3.7.1-r3
		>=dev-libs/fftw-2.1.3
		>=dev-util/gperf-2.7.2"
RDEPEND="${DEPEND}"
PROVIDE="dev-lang/octave"

LICENSE="GPL-2"
KEYWORDS="x86 ppc"
SLOT="0"

# NOTE: octave supports blas/lapack from intel but this is not open
# source nor is it free (as in beer OR speech) Check out...
# http://developer.intel.com/software/products/mkl/mkl52/index.htm for
# more information

src_unpack() {

	unpack ${A}
	cd ${WORKDIR}
	patch -p0 < ${FILESDIR}/filebuf.diff

}

src_compile() {
	# NOTE: This version actually works with gcc-3.x
	./configure --prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var/state/octave \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--host=${CHOST} \
		--build=${CHOST} \
		--target=${CHOST} \
		--enable-dl \
		--enable-shared \
		--enable-rpath \
		--enable-lite-kernel || die "configure failed"

	emake || die "emake failed"

}

src_install () {
	
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die "make install failed"

}
