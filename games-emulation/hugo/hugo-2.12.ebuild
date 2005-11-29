# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/hugo/hugo-2.12.ebuild,v 1.1 2005/11/29 17:25:15 mr_bones_ Exp $

inherit games

DESCRIPTION="PC-Engine (Turbografx16) emulator for linux"
HOMEPAGE="http://www.zeograd.com/"
SRC_URI="http://www.zeograd.com/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="virtual/x11
	media-libs/libsdl"

src_install() {
	dogamesbin hugo || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r pixmaps || die "doins gamedata failed"
	dodoc AUTHORS Changlog NEWS README TODO || die "dodoc failed"
	dohtml doc/*html
	prepgamesdirs
}
