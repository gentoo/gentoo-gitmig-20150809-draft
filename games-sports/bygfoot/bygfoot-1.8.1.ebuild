# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/bygfoot/bygfoot-1.8.1.ebuild,v 1.4 2005/06/15 19:10:45 wolf31o2 Exp $

inherit games

DESCRIPTION="GTK+2 Soccer Management Game"
HOMEPAGE="http://bygfoot.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"

# Other depends would be (and why not listed):
# * pkgconfig > 0.9.0 - Oldest ebuild is 0.12.0
# * glib2, pango, atk - Depends from gtk+2
# * freetype2 - Depends from pango
DEPEND=">=x11-libs/gtk+-2.0
	dev-util/pkgconfig"

src_install() {
	dogamesbin src/bygfoot || die "Installation bygfoot failed."
	dogamesbin b-u/bygfoot-update-gui || die "Installation of bygfoot failed."
	dodoc AUTHORS ChangeLog README TODO UPDATE
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r support_files/ || die "Installation of game data failed."
	newicon support_files/pixmaps/football.png ${PN}.png
	make_desktop_entry ${PN} "Bygfoot" ${PN}.png

	prepgamesdirs
}
