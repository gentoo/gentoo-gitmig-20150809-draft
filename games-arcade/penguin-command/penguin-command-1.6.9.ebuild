# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/penguin-command/penguin-command-1.6.9.ebuild,v 1.3 2006/09/28 20:55:11 nyhm Exp $

inherit eutils games

DESCRIPTION="A clone of the classic Missile Command Game"
HOMEPAGE="http://www.linux-games.com/penguin-command/"
SRC_URI="mirror://sourceforge/penguin-command/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="nls"

DEPEND="media-libs/libpng
	media-libs/jpeg
	>=media-libs/libsdl-1.1.5
	media-libs/sdl-mixer
	media-libs/sdl-image"

src_install() {
	make install DESTDIR="${D}" || die
	dodoc ChangeLog README NEWS AUTHORS
	if use nls ; then
		dodir /usr/share/man/ja/man6
		mv "${D}"/usr/share/man/man6/penguin-command.ja.6 "${D}"/usr/share/man/ja/man6/penguin-command.6
	else
		rm -f "${D}"/usr/share/man/man6/*.ja.*
	fi
	newicon data/gfx/icon.xpm ${PN}.xpm
	make_desktop_entry ${PN} ${PN} ${PN}.xpm
	prepgamesdirs
}
