# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/octave/octave-2.1.36-r1.ebuild,v 1.9 2003/12/30 17:09:38 usata Exp $

inherit flag-o-matic eutils

IUSE="tetex"

DESCRIPTION="GNU Octave is a high-level language (MatLab compatible) intended for numerical computations"
HOMEPAGE="http://www.octave.org/"
SRC_URI="ftp://ftp.octave.org/pub/octave/bleeding-edge/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2-r3
	>=media-gfx/gnuplot-3.7.1-r3
	>=dev-libs/fftw-2.1.3
	>=dev-util/gperf-2.7.2
	tetex? ( virtual/tetex ) "
PROVIDE="dev-lang/octave"

# NOTE: octave supports blas/lapack from intel but this is not open
# source nor is it free (as in beer OR speech) Check out...
# http://developer.intel.com/software/products/mkl/mkl52/index.htm for
# more information

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	epatch ${FILESDIR}/filebuf.diff

}

src_compile() {

	filter-flags -ffast-math

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

	patch -p1 < ${FILESDIR}/kill-dvips.diff || die
	emake || die "emake failed"
}

src_install() {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die "make install failed"
	use tetex && octave-install-doc
}

octave-install-doc() {
	echo "Installing documentation..."
	insinto /usr/share/doc/${PF}
	doins doc/faq/Octave-FAQ.dvi
	doins doc/interpreter/octave.dvi
	doins doc/liboctave/liboctave.dvi
	doins doc/refcard/refcard-a4.dvi
	doins doc/refcard/refcard-legal.dvi
	doins doc/refcard/refcard-letter.dvi
}
