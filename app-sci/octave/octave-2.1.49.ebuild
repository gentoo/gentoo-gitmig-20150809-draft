# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/octave/octave-2.1.49.ebuild,v 1.1 2003/06/09 20:09:37 george Exp $

DESCRIPTION="GNU Octave is a high-level language (MatLab compatible) intended for numerical computations"
SRC_URI="ftp://ftp.octave.org/pub/octave/bleeding-edge/${P}.tar.bz2"
HOMEPAGE="http://www.octave.org/"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~alpha"
SLOT="0"
IUSE="static readline zlib tetex"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2-r3
	>=media-gfx/gnuplot-3.7.1-r3
	>=dev-libs/fftw-2.1.3
	>=dev-util/gperf-2.7.2
	zlib? ( sys-libs/zlib )
	tetex? ( >=tetex-1.0.7-r10 ) "

# NOTE: octave supports blas/lapack from intel but this is not open
# source nor is it free (as in beer OR speech) Check out...
# http://developer.intel.com/software/products/mkl/mkl52/index.htm for
# more information

src_compile() {
	local myconf

	use static || myconf="--disable-static --enable-shared --enable-dl"
	use readline || myconf="${myconf} --disable-readline"

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
		LDFLAGS=-lz || die "configure failed"

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
