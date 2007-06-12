# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/ascal/ascal-0.1.1.ebuild,v 1.2 2007/06/12 13:02:29 nyhm Exp $

inherit eutils games

DESCRIPTION="A game similar to Draughts but with some really cool enhancements"
HOMEPAGE="http://ascal.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-cpp/libgnomecanvasmm
	dev-cpp/libglademm"

src_compile() {
	egamesconf --disable-Werror || die "egamesconf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	rm "${D}${GAMES_DATADIR}/pixmaps/${PN}.png" \
		|| die "Cleaning pixmap entry failed"
	rm "${D}${GAMES_DATADIR}/applications/${PN}.desktop" \
		|| die "Cleaning desktop entry failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS

	doicon ${PN}.png
	make_desktop_entry ${PN} "Ascal" ${PN}.png

	prepgamesdirs
}
