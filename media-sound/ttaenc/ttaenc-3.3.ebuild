# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ttaenc/ttaenc-3.3.ebuild,v 1.1 2007/04/22 11:02:07 drac Exp $

inherit eutils toolchain-funcs

DESCRIPTION="True Audio Compressor Software"
HOMEPAGE="http://tta.sourceforge.net"
SRC_URI="mirror://sourceforge/tta/${P}-src.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=""

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-cflags.patch
	epatch "${FILESDIR}"/${P}-warnings.patch
	
	sed -i -e "s:gcc:$(tc-getCC):g" Makefile
}

src_compile () {
	emake || die "emake failed."
}

src_install () {
	dobin ttaenc
	dodoc Readme
}
