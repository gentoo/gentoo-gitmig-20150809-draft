# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/xblast/xblast-2.9.22.ebuild,v 1.2 2004/10/18 12:29:23 dholm Exp $

inherit games

DESCRIPTION="Bomberman clone w/network support for up to 6 players"
HOMEPAGE="http://xblast.sourceforge.net/"
SRC_URI="mirror://sourceforge/xblast/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND="virtual/x11
	media-libs/libpng"

src_compile() {
	export MY_DATADIR="${GAMES_DATADIR}/${PN}"
	egamesconf \
		--enable-sound \
		--with-otherdatadir="${MY_DATADIR}" \
		|| die
	emake || die "emake failed"
}

src_install() {
	egamesinstall game_datadir="${D}${MY_DATADIR}" || die
	dodoc AUTHORS ChangeLog NEWS README
	find "${D}${MY_DATADIR}" \( -name "*akefile*" -o -name "*~" \) \
		-exec rm -f \{\} \;
	find "${D}${MY_DATADIR}" -type f -exec chmod a-x \{\} \;
	prepgamesdirs
}
