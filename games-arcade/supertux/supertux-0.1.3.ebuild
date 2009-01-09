# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/supertux/supertux-0.1.3.ebuild,v 1.12 2009/01/09 21:07:33 mr_bones_ Exp $

EAPI=2
GAMES_USE_SDL="nojoystick" #bug #100372
inherit eutils games

DESCRIPTION="A game similar to Super Mario Bros."
HOMEPAGE="http://super-tux.sourceforge.net"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 sparc x86 ~x86-fbsd"
IUSE="opengl"

DEPEND="media-libs/libsdl
	media-libs/sdl-image[png,jpeg]
	media-libs/sdl-mixer[mikmod,vorbis]
	x11-libs/libXt"

PATCHES=( "${FILESDIR}"/${P}-gcc41.patch "${FILESDIR}"/${P}-ndebug.patch )

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		--disable-debug \
		$(use_enable opengl) \
		|| die
}

src_install() {
	emake DESTDIR="${D}" \
		desktopdir=/usr/share/applications \
		icondir=/usr/share/pixmaps \
		install || die "emake install failed"
	dodoc AUTHORS ChangeLog LEVELDESIGN README TODO
	prepgamesdirs
}
