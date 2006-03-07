# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/fftw/fftw-3.1.ebuild,v 1.2 2006/03/07 22:01:43 markusle Exp $

inherit flag-o-matic eutils toolchain-funcs

DESCRIPTION="C subroutine library for computing the Discrete Fourier Transform (DFT)"
HOMEPAGE="http://www.fftw.org/"
SRC_URI="http://www.fftw.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="3.0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc-macos ~ppc64 ~sparc ~x86"
IUSE="3dnow altivec sse sse2"

DEPEND=""

src_unpack() {
	unpack "${P}.tar.gz"
	cd "${S}"
	cd "${WORKDIR}"
	use ppc-macos && epatch "${FILESDIR}"/${PN}-ppc-macos.patch
	mv ${P} ${P}-single
	cp -pPR ${P}-single ${P}-double
}

src_compile() {
	# filter -Os according to docs
	replace-flags -Os -O2

	local myconfsingle=""
	local myconfdouble=""

	if use sse2; then
		myconfsingle="$myconfsingle --enable-sse"
		myconfdouble="$myconfdouble --enable-sse2"
	elif use sse; then
		myconfsingle="$myconfsingle --enable-sse"
	elif use 3dnow; then
		myconfsingle="$myconfsingle --enable-k7"
	fi

	# disable building of shared libs for k7 (c.f. bug #125218)
	if ! use 3dnow; then
		myconfsingle="$myconfsingle --enable-shared"
		myconfdouble="$myconfdouble --enable-shared"
	fi


	# Altivec-support in fftw is currently broken
	# with gcc 3.4
	if [ "`gcc-version`" != "3.4" ]; then
		myconfsingle="$myconfsingle `use_enable altivec`"
	fi

	cd "${S}-single"
	econf \
		--enable-threads \
		--enable-float \
		${myconfsingle} || \
			die "./configure in single failed"
	emake || die

	#the only difference here is no --enable-float
	cd "${S}-double"
	econf \
		--enable-threads \
		${myconfdouble} || \
		die "./configure in double failed"
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
