# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/octave/octave-2.1.57-r1.ebuild,v 1.10 2004/11/30 15:02:53 phosphan Exp $

inherit flag-o-matic

DESCRIPTION="GNU Octave is a high-level language (MatLab compatible) intended for numerical computations"
HOMEPAGE="http://www.octave.org/"
SRC_URI="ftp://ftp.octave.org/pub/octave/bleeding-edge/${P}.tar.bz2
		ftp://ftp.math.uni-hamburg.de/pub/soft/math/octave/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~alpha ~sparc amd64"
IUSE="emacs static readline zlib tetex hdf5 mpi ifc blas"

DEPEND="virtual/libc
	>=sys-libs/ncurses-5.2-r3
	>=media-gfx/gnuplot-3.7.1-r3
	>=dev-libs/fftw-2.1.3
	>=dev-util/gperf-2.7.2
	zlib? ( sys-libs/zlib )
	hdf5? ( dev-libs/hdf5 )
	tetex? ( virtual/tetex )
	x86? ( ifc? ( dev-lang/ifc ) )
	blas? ( virtual/blas )"

# NOTE: octave supports blas/lapack from intel but this is not open
# source nor is it free (as in beer OR speech) Check out...
# http://developer.intel.com/software/products/mkl/mkl52/index.htm for
# more information

pkg_setup() {
	use ifc || if [ -z `which g77` ]; then
		#if ifc is defined then the dep was already checked
		eerror "No fortran compiler found on the system!"
		eerror "Please add f77 to your USE flags and reemerge gcc!"
		die
	fi
}

src_compile() {
	filter-flags -ffast-math

	local myconf

	use static || myconf="--disable-static --enable-shared --enable-dl"
	use readline || myconf="${myconf} --disable-readline"
	use hdf5 || myconf="${myconf} --without-hdf5"
	use mpi  || myconf="${myconf} --without-mpi"

	# Only add -lz to LDFLAGS if we have zlib in USE !
	# BUG #52604
	# Danny van Dyk 2004/08/26
	use zlib && LDFLAGS="${LDFLAGS} -lz"

	# NOTE: This version actually works with gcc-3.x
	./configure ${myconf} --prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var/state/octave \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--host=${CHOST} \
		--build=${CHOST} \
		--target=${CHOST} \
		--enable-rpath \
		--enable-lite-kernel \
		LDFLAGS="${LDFLAGS}" || die "configure failed"

	emake || die "emake failed"
}

src_install() {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die "make install failed"
	use tetex && octave-install-doc
	if use emacs; then
		cd emacs
		exeinto /usr/bin
		doexe otags
		doman otags.1
		for emacsdir in /usr/share/emacs/site-lisp /usr/lib/xemacs/site-lisp; do
			insinto ${emacsdir}
			doins *.el
		done
		cd ..
	fi
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
