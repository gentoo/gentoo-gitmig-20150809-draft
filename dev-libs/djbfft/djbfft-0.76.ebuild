# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/djbfft/djbfft-0.76.ebuild,v 1.13 2004/11/22 23:57:08 kloeri Exp $

IUSE="static"

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="extremely fast library for floating-point convolution"
HOMEPAGE="http://cr.yp.to/djbfft.html"
SRC_URI="http://cr.yp.to/djbfft/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ~hppa ~ppc sparc x86 ~alpha"

src_unpack() {
	MY_PV="${PV:0:1}.${PV:2:1}.${PV:3:1}" # a.bc -> a.b.c
	MY_D="${D}usr"

	# mask out everything, which is not suggested by the author (RTFM)!
	ALLOWED_FLAGS="-fstack-protector -march -mcpu -pipe -mpreferred-stack-boundary -ffast-math"
	strip-flags

	MY_CFLAGS="$CFLAGS -O1 -fomit-frame-pointer"
	use x86 && MY_CFLAGS="$MY_CFLAGS -malign-double"

	if use static ; then
		LIBPERMS="0644"
		LIBDJBFFT="libdjbfft.a"
	else
		LIBPERMS="0755"
		LIBDJBFFT="libdjbfft.so.${MY_PV}"
	fi

	unpack "${A}"
	cd "${S}"
	epatch "${FILESDIR}/${P}-gcc3.patch"
	epatch "${FILESDIR}/${P}-shared.patch"
	if use static ; then
		echo "$(tc-getCC) $MY_CFLAGS" > "conf-cc"
	else
		echo "$(tc-getCC) $MY_CFLAGS -fPIC -DPIC" > "conf-cc"
	fi
	echo "$(tc-getCC) $LDFLAGS" > "conf-ld"
	echo "${MY_D}" > "conf-home"
	einfo "conf-cc: $(<conf-cc)"
}

src_compile() {
	emake LIBDJBFFT="$LIBDJBFFT" LIBPERMS="$LIBPERMS" || die
}

src_install() {
	make LIBDJBFFT="$LIBDJBFFT" setup check || die
	if ! use static ; then
		ln -snf "${LIBDJBFFT}" "${MY_D}/lib/libdjbfft.so"
		ln -snf "${LIBDJBFFT}" "${MY_D}/lib/libdjbfft.so.${MY_PV%%.*}"
	fi
	dodoc CHANGES README TODO VERSION
}
