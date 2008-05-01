# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/crystal/crystal-0.2.2.ebuild,v 1.2 2008/05/01 10:30:07 nyhm Exp $

inherit eutils games

DESCRIPTION="The crystal MUD client"
HOMEPAGE="http://www.evilmagic.org/crystal/"
SRC_URI="http://www.evilmagic.org/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND="sys-libs/zlib
	sys-libs/ncurses
	dev-libs/openssl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch \
		"${FILESDIR}"/${P}-64bit.patch \
		"${FILESDIR}"/${P}-gcc43.patch
}

src_compile() {
	egamesconf \
		--disable-scripting || die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS NEWS README TODO
	prepgamesdirs
}
