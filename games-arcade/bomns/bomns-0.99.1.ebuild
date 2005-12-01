# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/bomns/bomns-0.99.1.ebuild,v 1.1 2005/12/01 01:14:18 wolf31o2 Exp $

inherit flag-o-matic games

MY_P="greenridge"
DESCRIPTION="A fast-paced multiplayer deathmatch arcade game."
HOMEPAGE="http://greenridge.sourceforge.net"
SRC_URI="mirror://sourceforge/${MY_P}/${PF}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk editor"

DEPEND="media-libs/libsdl
	media-libs/sdl-mixer
	gtk? ( =x11-libs/gtk+-2* )"

src_compile() {
	filter-flags -fforce-addr
	egamesconf \
	--disable-launcher1 \
	$(use_enable gtk2 launcher2) \
	$(use_enable editor editor) \
	|| die "econf failed."
}

src_install() {
	make DESTDIR=${D} install || die "make install failed."
	dodoc AUTHORS README NEWS TODO
	prepgamesdirs
}
