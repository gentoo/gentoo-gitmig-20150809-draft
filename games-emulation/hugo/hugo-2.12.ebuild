# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/hugo/hugo-2.12.ebuild,v 1.3 2006/05/02 18:35:17 tupone Exp $

inherit eutils games

DESCRIPTION="PC-Engine (Turbografx16) emulator for linux"
HOMEPAGE="http://www.zeograd.com/"
SRC_URI="http://www.zeograd.com/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="x11-libs/gtk+
		media-libs/libsdl
		media-libs/libvorbis"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}"-gcc41.patch
}

src_install() {
	dogamesbin hugo || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r pixmaps || die "doins gamedata failed"
	dodoc AUTHORS ChangeLog NEWS README TODO || die "dodoc failed"
	dohtml doc/*html
	prepgamesdirs
}
