# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/rio/rio-1.0.7-r1.ebuild,v 1.3 2007/12/25 15:08:41 cla Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Utility for the Diamond Rio 300 portable MP3 player"
HOMEPAGE="http://www.world.co.uk/sba/rio.html"
SRC_URI="http://www.world.co.uk/sba/${PN}007.tgz"

KEYWORDS="~amd64 x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="virtual/libc"
RDEPEND=""

S="${WORKDIR}/${PN}${PV//./}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-makefile.patch
	epatch "${FILESDIR}"/${P}-gentoo.patch
	epatch "${FILESDIR}"/${P}-includes.patch
}

src_compile() {
	emake CXX="$(tc-getCXX)" || die "emake failed."
}

src_install() {
	dobin rio
	dodoc CREDITS README playlist.txt rio.txt
}
