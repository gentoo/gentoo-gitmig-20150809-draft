# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/rio/rio-1.0.7-r1.ebuild,v 1.1 2005/08/20 03:07:11 vanquirius Exp $

inherit eutils

DESCRIPTION="Utility for the Diamond Rio 300 portable MP3 player"
HOMEPAGE="http://www.world.co.uk/sba/rio.html"
SRC_URI="http://www.world.co.uk/sba/${PN}007.tgz"

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="virtual/libc"
RDEPEND=""

S="${WORKDIR}/${PN}${PV//./}"

src_unpack() {
	unpack ${A}; cd ${S}
	epatch ${FILESDIR}/${P}-makefile.patch
	epatch ${FILESDIR}/${P}-gentoo.patch
}

src_compile() {
	emake || die "compile failed"
}

src_install() {
	dobin rio || die
	dodoc CREDITS README gpl.txt playlist.txt rio.txt
}
