# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/wesnoth/wesnoth-0.7.3.ebuild,v 1.2 2004/04/21 06:42:44 mr_bones_ Exp $

inherit flag-o-matic games

DESCRIPTION="A fantasy turn-based strategy game"
HOMEPAGE="http://www.wesnoth.org/"
SRC_URI="http://www.wesnoth.org/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ppc ~sparc"
IUSE="server editor tools gnome kde"

DEPEND=">=media-libs/libsdl-1.2
	>=media-libs/sdl-image-1.2
	>=media-libs/sdl-mixer-1.2
	>=media-libs/sdl-ttf-2.0
	media-libs/sdl-net
	virtual/x11"

src_compile() {
	append-flags -fsigned-char

	egamesconf \
		--disable-dependency-tracking \
		$(use_enable server) \
		$(use_enable editor) \
		$(use_enable tools) \
		$(use_enable gnome) \
		$(use_enable kde) \
			|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	mv "${D}${GAMES_DATADIR}/icons" "${D}/usr/share/"
	dodoc MANUAL changelog || die "dodoc failed"
	prepgamesdirs
}
