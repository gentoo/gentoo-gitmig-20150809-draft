# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/fftw/fftw-3.0.1-r2.ebuild,v 1.1 2005/08/10 14:00:53 phosphan Exp $

inherit flag-o-matic eutils toolchain-funcs

DESCRIPTION="C subroutine library for computing the Discrete Fourier Transform (DFT)"
HOMEPAGE="http://www.fftw.org/"
SRC_URI="http://www.fftw.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="3.0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc-macos ~ppc64 ~sparc x86"
IUSE="3dnow altivec mpi sse sse2"

DEPEND="virtual/libc"

src_unpack() {
	unpack "${P}.tar.gz"
	cd "${WORKDIR}/${P}"
	epatch ${FILESDIR}/3-tmpfile.patch
	cd "${WORKDIR}"
	use ppc-macos && epatch ${FILESDIR}/${PN}-ppc-macos.patch
	mv ${P} ${P}-single
	cp -a ${P}-single ${P}-double
}

src_compile() {
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

	local myconf=""
	local myconfsingle=""
	local myconfdouble=""

	use mpi && myconf="${myconf} --enable-mpi"
	#mpi is not a valid flag yet. In this revision it is used merely to block --enable-mpi option
	#it might be needed if it is decided that lam is an optional dependence

	if use sse2; then
		myconfsingle="$myconfsingle --enable-sse"
		myconfdouble="$myconfdouble --enable-sse2"
	elif use sse; then
		myconfsingle="$myconfsingle --enable-sse"
	elif use 3dnow; then
		myconfsingle="$myconfsingle --enable-k7"
	fi

	# Altivec-support in fftw is currently broken
	# with gcc 3.4
	if [ "`gcc-version`" != "3.4" ]; then
		myconfsingle="$myconfsingle `use_enable altivec`"
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

	dodoc AUTHORS ChangeLog NEWS README TODO COPYRIGHT CONVENTIONS

	cd doc/html
	dohtml -r .
}
