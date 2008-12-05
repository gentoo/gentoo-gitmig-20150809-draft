# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/alephone/alephone-20080721.ebuild,v 1.3 2008/12/05 10:08:13 armin76 Exp $

inherit games

MY_P=AlephOne-${PV}
DESCRIPTION="An enhanced version of the game engine from the classic Mac game, Marathon"
HOMEPAGE="http://source.bungie.org/"
SRC_URI="mirror://sourceforge/marathon/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc64 x86"
IUSE="alsa mad mpeg opengl sndfile speex truetype vorbis"

RDEPEND="media-libs/sdl-net
	media-libs/sdl-image
	media-libs/libsdl
	alsa? ( media-libs/alsa-lib )
	mad? ( media-libs/libmad )
	mpeg? ( media-libs/smpeg )
	opengl? ( virtual/opengl )
	sndfile? ( media-libs/libsndfile )
	speex? ( media-libs/speex )
	truetype? ( media-libs/sdl-ttf )
	vorbis? ( media-libs/libvorbis )"
DEPEND="${RDEPEND}
	dev-libs/boost"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed "s:GAMES_DATADIR:${GAMES_DATADIR}:g" \
		"${FILESDIR}"/${PN}.sh > "${T}"/${PN}.sh \
		|| die "sed failed"
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		--enable-lua \
		$(use_enable alsa) \
		$(use_enable mad) \
		$(use_enable mpeg smpeg) \
		$(use_enable opengl) \
		$(use_enable sndfile) \
		$(use_enable speex) \
		$(use_enable truetype ttf) \
		$(use_enable vorbis) \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dogamesbin "${T}"/${PN}.sh || die "dogamesbin failed"
	doman docs/${PN}.6
	dodoc AUTHORS ChangeLog README
	dohtml docs/*.html
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
