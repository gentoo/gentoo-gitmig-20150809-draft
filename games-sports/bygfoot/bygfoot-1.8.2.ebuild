# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/bygfoot/bygfoot-1.8.2.ebuild,v 1.2 2005/07/17 06:02:33 vapier Exp $

inherit eutils games

DESCRIPTION="GTK+2 Soccer Management Game"
HOMEPAGE="http://bygfoot.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	dogamesbin src/bygfoot b-u/bygfoot-update-gui || die "dobin failed"
	dodoc AUTHORS ChangeLog README TODO UPDATE
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r support_files/ || die "game data failed"
	newicon support_files/pixmaps/football.png ${PN}.png
	make_desktop_entry ${PN} "Bygfoot"
	prepgamesdirs
}
