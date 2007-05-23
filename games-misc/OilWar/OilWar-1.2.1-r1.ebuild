# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/OilWar/OilWar-1.2.1-r1.ebuild,v 1.1 2007/05/23 06:08:16 tupone Exp $

inherit eutils games

DESCRIPTION="Evil army is attacking your country and tries to steal your oil"
HOMEPAGE="http://www.2ndpoint.fi/projektit/oilwar.html"
SRC_URI="http://www.2ndpoint.fi/projektit/filut/${P}.tar.gz
	${PN}.png"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
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
	doicon "${DISTDIR}"/${PN}.png
	make_desktop_entry oilwar ${PN} ${PN}.png
	prepgamesdirs
}
