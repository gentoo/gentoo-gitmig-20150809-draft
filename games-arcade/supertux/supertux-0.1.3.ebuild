# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/supertux/supertux-0.1.3.ebuild,v 1.3 2006/01/13 22:02:32 genstef Exp $

GAMES_USE_SDL="nojoystick" #bug #100372
inherit eutils games

DESCRIPTION="A game similar to Super Mario Bros."
HOMEPAGE="http://super-tux.sourceforge.net"
SRC_URI=" http://download.berlios.de/supertux/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="opengl"

RDEPEND=">=media-libs/libsdl-1.2.4
	>=media-libs/sdl-image-1.2.2
	>=media-libs/sdl-mixer-1.2.5
	sys-libs/zlib"
DEPEND="${RDEPEND}
	|| ( x11-libs/libXt virtual/x11 )"

pkg_setup() {
	if ! built_with_use media-libs/sdl-mixer mikmod ; then
		die "Please emerge sdl-mixer with USE=mikmod"
	fi
	games_pkg_setup
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		--disable-debug \
		$(use_enable opengl) \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" \
		desktopdir=/usr/share/applications \
		icondir=/usr/share/pixmaps \
		install || die "make install failed"
	dodoc AUTHORS ChangeLog LEVELDESIGN README TODO
	prepgamesdirs
}
