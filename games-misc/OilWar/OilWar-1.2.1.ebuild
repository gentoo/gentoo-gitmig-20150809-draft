# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/OilWar/OilWar-1.2.1.ebuild,v 1.6 2004/11/22 11:35:27 josejx Exp $

inherit games

DESCRIPTION="Evil army is attacking your country and tries to steal your oil"
HOMEPAGE="http://www.2ndpoint.fi/projektit/oilwar.html"
SRC_URI="http://www.2ndpoint.fi/projektit/filut/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i '/^datafiledir/s:/games/:/:' Makefile.in || die "sed failed"
}

src_compile() {
	egamesconf --enable-sound || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog NEWS README TODO
	prepgamesdirs
}
