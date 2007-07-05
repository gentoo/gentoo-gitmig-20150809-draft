# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/alephone/alephone-20061228.ebuild,v 1.4 2007/07/05 20:04:34 corsair Exp $

inherit autotools eutils games

DESCRIPTION="An enhanced version of the game engine from the classic Mac game, Marathon"
HOMEPAGE="http://source.bungie.org/"
SRC_URI="mirror://sourceforge/marathon/AlephOne-${PV}-nolibs.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc64 x86"
IUSE="lua opengl speex"

DEPEND="lua? ( dev-lang/lua )
	opengl? ( virtual/opengl )
	speex? ( media-libs/speex )
	dev-libs/boost
	media-libs/smpeg
	media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-sound
	media-libs/sdl-net"

S=${WORKDIR}/AlephOne-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed "s:GAMES_DATADIR:${GAMES_DATADIR}:g" \
		"${FILESDIR}"/${PN}.sh > "${T}"/${PN}.sh \
		|| die "sed failed"
	epatch "${FILESDIR}"/${P}-configure.patch
	eautoreconf
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		$(use_enable lua) \
		$(use_enable opengl) \
		$(use_enable speex) \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dogamesbin "${T}"/${PN}.sh || die "dogamesbin failed"
	dodoc AUTHORS README docs/Cheat_Codes
	dohtml docs/MML.html
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	elog "Read the docs and install the data files accordingly to play."
	echo
	elog "If you only want to install one scenario, read"
	elog "http://traxus.jjaro.net/traxus/AlephOne:Install_Guide#Single_scenario_3"
	elog "If you want to install multiple scenarios, read"
	elog "http://traxus.jjaro.net/traxus/AlephOne:Install_Guide#Multiple_scenarios_3"
	echo
}
