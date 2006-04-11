# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/fftw/fftw-3.1.1.ebuild,v 1.2 2006/04/11 04:58:06 markusle Exp $

inherit flag-o-matic eutils toolchain-funcs

DESCRIPTION="C subroutine library for computing the Discrete Fourier Transform (DFT)"
HOMEPAGE="http://www.fftw.org/"
SRC_URI="http://www.fftw.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="3.0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc-macos ~ppc64 ~sparc ~x86"
IUSE="altivec sse sse2"

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	if [[ "${ARCH}" == "ppc-macos" ]];then
		epatch "${FILESDIR}"/${PN}-ppc-macos.patch
	fi

	# fix altivec compilation problems (bug #129304)
	epatch "${FILESDIR}"/${PN}-altivec-headers.patch

	cd "${WORKDIR}"
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
	fi

	cd "${S}-single"
	econf \
		--enable-shared \
		--enable-threads \
		--enable-float \
		$(use_enable altivec) \
		${myconfsingle} || \
			die "./configure in single failed"
	emake || die

	#the only difference here is no --enable-float
	cd "${S}-double"
	econf \
		--enable-shared \
		--enable-threads \
		$(use_enable altivec) \
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
