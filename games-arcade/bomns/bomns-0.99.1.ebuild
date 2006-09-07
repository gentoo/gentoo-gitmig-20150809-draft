# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/bomns/bomns-0.99.1.ebuild,v 1.2 2006/09/07 07:50:27 mr_bones_ Exp $

inherit flag-o-matic games

DESCRIPTION="A fast-paced multiplayer deathmatch arcade game."
HOMEPAGE="http://greenridge.sourceforge.net"
SRC_URI="mirror://sourceforge/greenridge/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk editor"

DEPEND="media-libs/libsdl
	media-libs/sdl-mixer
	gtk? ( =x11-libs/gtk+-2* )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s:\$*[({]prefix[})]/share:${GAMES_DATADIR}:" \
		configure \
		graphics/Makefile.in \
		levels/Makefile.in \
		sounds/Makefile.in \
		|| die "sed failed"
}

src_compile() {
	filter-flags -fforce-addr
	egamesconf \
		--disable-launcher1 \
		$(use_enable gtk launcher2) \
		$(use_enable editor) \
		|| die "econf failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed."
	dodoc AUTHORS ChangeLog NEWS README TODO
	prepgamesdirs
}
