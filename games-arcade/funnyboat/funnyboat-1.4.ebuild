# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/funnyboat/funnyboat-1.4.ebuild,v 1.2 2007/03/18 06:47:06 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="A side scrolling shooter game starring a steamboat on the sea"
HOMEPAGE="http://funnyboat.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2 MIT"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

RDEPEND=">=dev-python/pygame-1.6.2"

S=${WORKDIR}/${PN}

src_install() {
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r data *.py || die "doins failed"
	dodoc *.txt
	games_make_wrapper ${PN} "python main.py" "${GAMES_DATADIR}"/${PN}
	newicon data/kuvake.png ${PN}.png
	make_desktop_entry ${PN} "Trip on the Funny Boat"
	prepgamesdirs
}
