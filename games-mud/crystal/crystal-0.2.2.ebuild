# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/crystal/crystal-0.2.2.ebuild,v 1.3 2009/06/14 00:17:47 nyhm Exp $

EAPI=2
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

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-64bit.patch \
		"${FILESDIR}"/${P}-gcc43.patch \
		"${FILESDIR}"/${P}-glibc2.10.patch
}

src_configure() {
	egamesconf \
		--disable-scripting || die
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS NEWS README TODO
	prepgamesdirs
}
