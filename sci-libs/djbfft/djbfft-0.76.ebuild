# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/djbfft/djbfft-0.76.ebuild,v 1.8 2007/02/04 18:26:10 blubb Exp $

inherit eutils flag-o-matic toolchain-funcs multilib

DESCRIPTION="extremely fast library for floating-point convolution"
HOMEPAGE="http://cr.yp.to/djbfft.html"
SRC_URI="http://cr.yp.to/djbfft/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="static"

# the "check" target of the Makefile (version 0.76 at least) only checks if
# all files were installed with correct permissions. Can't check that at
# this point of the installation.
RESTRICT="test"

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
	sed -i -e "s:\"lib\":\"$(get_libdir)\":" hier.c
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
