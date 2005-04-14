# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmad/libmad-0.15.1b.ebuild,v 1.21 2005/04/14 15:07:53 geoman Exp $

inherit eutils

DESCRIPTION="\"M\"peg \"A\"udio \"D\"ecoder library"
HOMEPAGE="http://mad.sourceforge.net"
SRC_URI="mirror://sourceforge/mad/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 -mips ppc ppc64 ppc-macos sparc x86"
IUSE="debug"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epunt_cxx #74490
}

src_compile() {
	local myconf="--enable-accuracy"
	# --enable-speed         optimize for speed over accuracy
	# --enable-accuracy      optimize for accuracy over speed
	# --enable-experimental  enable code using the EXPERIMENTAL
	#                        preprocessor define

	# Fix for b0rked sound on sparc64 (maybe also sparc32?)
	# default/approx is also possible, uses less cpu but sounds worse
	use sparc && myconf="${myconf} --enable-fpm=64bit"

	econf \
		$(use_enable debug debugging) \
		${myconf} || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"

	dodoc CHANGES CREDITS README TODO VERSION

	# This file must be updated with each version update
	dodir /usr/$(get_libdir)/pkgconfig
	insinto /usr/$(get_libdir)/pkgconfig
	doins ${FILESDIR}/mad.pc
}
