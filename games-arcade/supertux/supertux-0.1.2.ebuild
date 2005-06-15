# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/supertux/supertux-0.1.2.ebuild,v 1.8 2005/06/15 18:13:11 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="A game similar to Super Mario Bros."
HOMEPAGE="http://super-tux.sourceforge.net"
SRC_URI="mirror://sourceforge/super-tux/${P}.tar.bz2"

KEYWORDS="x86 ppc amd64 sparc"
LICENSE="GPL-2"
SLOT="0"
IUSE="opengl"

DEPEND="virtual/opengl
	virtual/x11
	>=media-libs/libsdl-1.1.5
	>=media-libs/sdl-image-1.2.2
	>=media-libs/sdl-mixer-1.2.5"

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
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog LEVELDESIGN README TODO

	newicon data/images/icon.xpm supertux.xpm

	make_desktop_entry supertux SuperTux supertux.xpm

	prepgamesdirs
}
