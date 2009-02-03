# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/pokerth/pokerth-0.6.3.ebuild,v 1.1 2009/02/03 01:52:57 mr_bones_ Exp $

EAPI=2
inherit eutils qt4 games

MY_P="PokerTH-${PV}-2-src"
DESCRIPTION="Texas Hold'em poker game"
HOMEPAGE="http://www.pokerth.net/"
SRC_URI="mirror://sourceforge/pokerth/${MY_P}.tar.bz2"

LICENSE="GPL-1 GPL-2 GPL-3 BitstreamVera public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dedicated"

DEPEND=">=dev-libs/boost-1.34.1
	>=net-libs/gnutls-2.2.2
	>=net-misc/curl-7.16
	!dedicated? (
		media-libs/libsdl
		media-libs/sdl-mixer[mikmod,vorbis]
		>=sys-libs/zlib-1.2.3
		|| ( x11-libs/qt-gui:4 x11-libs/qt:4 )
	)"

S=${WORKDIR}/${MY_P}

src_prepare() {
	if use dedicated ; then
		sed -i \
			-e 's/pokerth_game.pro//' \
			pokerth.pro \
			|| die "sed failed"
	fi
}

src_configure() {
	eqmake4
}

src_install() {
	dogamesbin bin/pokerth_server || die
	if ! use dedicated ; then
		dogamesbin ${PN} || die
		insinto "${GAMES_DATADIR}/${PN}"
		doins -r data || die
		domenu ${PN}.desktop
		doicon ${PN}.png
	fi
	dodoc ChangeLog TODO docs/{net_protocol,server_setup_howto}.txt
	prepgamesdirs
}
