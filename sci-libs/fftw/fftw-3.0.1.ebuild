# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/fftw/fftw-3.0.1.ebuild,v 1.3 2005/03/28 19:31:13 hansmi Exp $

IUSE="3dnow sse mpi"

inherit flag-o-matic

DESCRIPTION="C subroutine library for computing the Discrete Fourier Transform (DFT)"
SRC_URI="http://www.fftw.org/${P}.tar.gz"
HOMEPAGE="http://www.fftw.org"

SLOT="3.0"
LICENSE="GPL-2"
DEPEND="virtual/libc"

KEYWORDS="x86 ppc sparc alpha ~ia64 amd64"

#-fpmath=xx is reported to cause trouble on pentium4 m series
#(for 3.0.x: this sort of thing should be handled by the --enable-sse
#style configure flags. these are set below using the use variables,
#but under gcc-3.2.x, sse2 seems to cause trouble.)
filter-mfpmath

# in gcc 3.2.3 at least, using sse or sse2 causes trouble with -O3
# according to the docs, -O0 can cause trouble too! So pending further
# testing, ...

if use sse; then
	filter-flags -O3 -O1 -O -Os
	append-flags -O2
fi

src_unpack() {
	unpack "${P}.tar.gz"
	cd "${WORKDIR}"
	mv ${P} ${P}-single

	unpack "${P}.tar.gz"
	cd "${WORKDIR}"
	mv ${P} ${P}-double
}


src_compile() {
	local myconf=""
	local myconfsingle=""
	local myconfdouble=""

	use mpi && myconf="${myconf} --enable-mpi"
	#mpi is not a valid flag yet. In this revision it is used merely to block --enable-mpi option
	#it might be needed if it is decided that lam is an optional dependence

	if use sse; then
		myconfsingle="$myconfsingle --enable-sse"
		myconfdouble="$myconfdouble --enable-sse2"
	elif use 3dnow; then
		myconfsingle="$myconfsingle --enable-3dnow"
	fi

	cd "${S}-single"
	econf \
		--enable-shared \
		--enable-threads \
		--enable-float \
		${myconf} ${myconfsingle} || die "./configure failed"
	emake || die

	#the only difference here is no --enable-float
	cd "${S}-double"
	econf \
		--enable-shared \
		--enable-threads \
		${myconf} ${myconfdouble} || die "./configure failed"
	emake || die
}

src_install () {
	#both builds are installed in the same place
	#libs have distinuguished names; include files, docs etc. identical.
	cd "${S}-single"
	make DESTDIR=${D} install || die

	cd "${S}-double"
	make DESTDIR=${D} install || die

	# Install documentation.
	cd "${S}-single"

	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README TODO
	dodoc COPYRIGHT CONVENTIONS

	cd doc/html
	dohtml -r .
}
