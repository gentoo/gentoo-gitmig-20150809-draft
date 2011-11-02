# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/pokerth/pokerth-0.8.3.ebuild,v 1.8 2011/11/02 09:05:55 eras Exp $

EAPI=2
inherit multilib flag-o-matic eutils qt4-r2 games

MY_P="PokerTH-${PV//_/-}-src"
DESCRIPTION="Texas Hold'em poker game"
HOMEPAGE="http://www.pokerth.net/"
SRC_URI="mirror://sourceforge/pokerth/${MY_P}.tar.bz2"

LICENSE="GPL-1 GPL-2 GPL-3 BitstreamVera public-domain"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="dedicated"

DEPEND=">=dev-libs/boost-1.41
	>=net-libs/gnutls-2.2.2
	>=net-misc/curl-7.16
	x11-libs/qt-core:4
	virtual/gsasl
	!dedicated? (
		media-libs/libsdl
		media-libs/sdl-mixer[mikmod,vorbis]
		>=sys-libs/zlib-1.2.3
		x11-libs/qt-gui:4
		x11-libs/qt-sql:4
	)"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-boost142.patch
	local boost_ver

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
	local boost_ver=$(best_version ">=dev-libs/boost-1.41")

	boost_ver=${boost_ver/*boost-/}
	boost_ver=${boost_ver%.*}
	boost_ver=${boost_ver/./_}

	einfo "Using boost version ${boost_ver}"
	append-cxxflags \
		-I/usr/include/boost-${boost_ver}
	append-ldflags \
		-L/usr/$(get_libdir)/boost-${boost_ver}
	append-flags -DBOOST_FILESYSTEM_VERSION=2

	export BOOST_INCLUDEDIR="/usr/include/boost-${boost_ver}"
	export BOOST_LIBRARYDIR="/usr/$(get_libdir)/boost-${boost_ver}"
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
