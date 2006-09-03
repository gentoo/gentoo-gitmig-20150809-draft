# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/terminus-font/terminus-font-4.11.ebuild,v 1.9 2006/09/03 06:45:24 vapier Exp $

DESCRIPTION="A clean fixed font for the console and X11"
HOMEPAGE="http://www.is-vn.bg/hamster/jimmy-en.html"
SRC_URI="http://www.is-vn.bg/hamster/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"
IUSE="X"

DEPEND="sys-apps/gawk
		dev-lang/perl
		X? ( || ( x11-apps/bdftopcf virtual/x11 ) )"
RDEPEND=""

src_compile() {
	./configure \
		--prefix=${D}/usr \
		--psfdir=${D}/usr/share/consolefonts \
		--acmdir=${D}/usr/share/consoletrans \
		--unidir=${D}/usr/share/consoletrans \
		--x11dir=${D}/usr/share/fonts/terminus

	make psf txt || die

	# If user wants fonts for X11
	if use X; then
		make pcf || die
	fi
}

src_install() {
	make install-psf install-acm install-ref || die

	# If user wants fonts for X11
	if use X; then
		make install-pcf || die
		mkfontdir ${D}/usr/share/fonts/terminus
	fi

	dodoc README*
}
