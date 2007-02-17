# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/clanbomber/clanbomber-1.05.ebuild,v 1.7 2007/02/17 08:47:09 nyhm Exp $

inherit autotools eutils games

DESCRIPTION="Bomberman-like multiplayer game"
HOMEPAGE="http://clanbomber.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="media-libs/hermes
	=dev-games/clanlib-0.6.5*"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e 's:\(@datadir@/clanbomber/\):$(DESTDIR)\1:' \
		clanbomber/{,*/}Makefile.am \
		|| die "sed failed"
	epatch \
		"${FILESDIR}"/${PV}-no-display.patch \
		"${FILESDIR}"/${PV}-gcc34.patch \
		"${FILESDIR}"/${P}-build.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog IDEAS QUOTES README
	prepgamesdirs
}
