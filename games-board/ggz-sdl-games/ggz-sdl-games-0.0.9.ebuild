# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/ggz-sdl-games/ggz-sdl-games-0.0.9.ebuild,v 1.1 2004/12/27 00:13:54 vapier Exp $

DESCRIPTION="These are the sdl versions of the games made by GGZ Gaming Zone"
HOMEPAGE="http://ggz.sourceforge.net/"
SRC_URI="http://ftp.ggzgamingzone.org/pub/ggz/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="gtk2"

DEPEND=">=games-board/ggz-gtk-client-${PV}
	>=dev-games/ggz-client-libs-${PV}
	>=media-libs/libsdl-1.2.0
	>=media-libs/sdl-image-1.2.0
	>=media-libs/sdl-ttf-1.2.0"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS QuickStart.GGZ README* TODO
}
