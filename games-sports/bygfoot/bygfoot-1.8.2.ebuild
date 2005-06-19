# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/bygfoot/bygfoot-1.8.2.ebuild,v 1.1 2005/06/19 05:38:32 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="GTK+2 Soccer Management Game"
HOMEPAGE="http://bygfoot.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

# Other depends would be (and why not listed):
# * pkgconfig > 0.9.0 - Oldest ebuild is 0.12.0
# * glib2, pango, atk - Depends from gtk+2
# * freetype2 - Depends from pango
RDEPEND=">=x11-libs/gtk+-2.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	dogamesbin src/bygfoot \
		b-u/bygfoot-update-gui || die "Installation of bygfoot failed."
	dodoc AUTHORS ChangeLog README TODO UPDATE
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r support_files/ || die "Installation of game data failed."
	newicon support_files/pixmaps/football.png ${PN}.png
	make_desktop_entry ${PN} "Bygfoot"
	prepgamesdirs
}
