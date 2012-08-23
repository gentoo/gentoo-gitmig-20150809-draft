# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/pokerth/pokerth-0.9.5.ebuild,v 1.6 2012/08/23 17:06:52 mr_bones_ Exp $

EAPI=2
inherit flag-o-matic eutils qt4-r2 games

MY_P="PokerTH-${PV}-src"
DESCRIPTION="Texas Hold'em poker game"
HOMEPAGE="http://www.pokerth.net/"
SRC_URI="mirror://sourceforge/pokerth/${MY_P}.tar.bz2"

LICENSE="AGPL-3 GPL-1 GPL-2 GPL-3 BitstreamVera public-domain"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="dedicated"

RDEPEND="dev-db/sqlite:3
	>=dev-libs/boost-1.44
	dev-libs/libgcrypt
	dev-libs/tinyxml[stl]
	net-libs/libircclient
	>=net-misc/curl-7.16
	x11-libs/qt-core:4
	virtual/gsasl
	!dedicated? (
		media-libs/libsdl
		media-libs/sdl-mixer[mod,vorbis]
		x11-libs/qt-gui:4
	)"
DEPEND="${RDEPEND}
	!dedicated? ( x11-libs/qt-sql:4 )"

S=${WORKDIR}/${MY_P}

src_prepare() {
	if use dedicated ; then
		sed -i \
			-e 's/pokerth_game.pro//' \
			pokerth.pro \
			|| die "sed failed"
	fi

	sed -i \
		-e '/no_dead_strip_inits_and_terms/d' \
		*pro \
		|| die 'sed failed'

	epatch "${FILESDIR}"/${P}-underlinking.patch

	local boost_ver=$(best_version ">=dev-libs/boost-1.41")

	boost_ver=${boost_ver/*boost-/}
	boost_ver=${boost_ver%.*}
	boost_ver=${boost_ver/./_}

	einfo "Using boost version ${boost_ver}"
	append-cppflags \
		-I/usr/include/boost-${boost_ver} -DBOOST_FILESYSTEM_VERSION=2
	append-ldflags \
		-L/usr/$(get_libdir)/boost-${boost_ver}

	export BOOST_INCLUDEDIR="/usr/include/boost-${boost_ver}"
	export BOOST_LIBRARYDIR="/usr/$(get_libdir)/boost-${boost_ver}"
}

src_configure() {
	append-ldflags $(no-as-needed)
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
	doman docs/pokerth.1
	dodoc ChangeLog TODO docs/{gui_styling,server_setup}_howto.txt
	prepgamesdirs
}
