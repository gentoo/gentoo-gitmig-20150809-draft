# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/ultrastar-ng/ultrastar-ng-0.2.1-r1.ebuild,v 1.4 2007/12/04 00:04:30 tupone Exp $

inherit eutils games

MY_PN=UltraStar-ng
MY_P=${MY_PN}-${PV}
SONGS_PN=ultrastar-songs
SONGS_P=${SONGS_PN}-1

DESCRIPTION="SingStar GPL clone"
HOMEPAGE="http://sourceforge.net/projects/ultrastar-ng/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz
	songs? ( mirror://sourceforge/${PN}/${SONGS_P}.tar.bz2 )"

LICENSE="GPL-2
	songs? (
		CCPL-Attribution-ShareAlike-NonCommercial-2.5
		CCPL-Attribution-NonCommercial-NoDerivs-2.5
	)"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="novideo opengl xine debug alsa gstreamer portaudio songs"

RDEPEND="gnome-base/librsvg
	dev-libs/boost
	x11-libs/pango
	media-libs/sdl-image
	media-libs/sdl-gfx
	xine? ( media-libs/xine-lib )
	!xine? ( media-libs/gstreamer )
	opengl? (
		virtual/opengl
		virtual/glu
	)
	alsa? ( media-libs/alsa-lib )
	portaudio? ( media-libs/portaudio )
	gstreamer? ( >=media-libs/gstreamer-0.10 )
	!novideo? ( media-libs/smpeg )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	games_pkg_setup
	if use opengl && ! built_with_use media-libs/libsdl opengl ; then
		eerror "opengl flag set, but libsdl wasn't build with opengl support"
	fi
	if ! built_with_use --missing true dev-libs/boost threads ; then
		eerror "Please emerge dev-libs/boost with USE=threads"
	fi
}

src_compile() {
	local myconf

	if use novideo; then
		myconf="--with-video=disable"
	else
		myconf="--with-video=smpeg"
	fi
	if use opengl; then
		myconf="$myconf --with-graphic-driver=opengl"
	else
		myconf="$myconf --with-graphic-driver=sdl"
	fi
	if use xine; then
		myconf="$myconf --with-audio=xine"
	else
		myconf="$myconf --with-audio=gstreamer"
	fi

	egamesconf \
		${myconf} \
		$(use_enable debug) \
		$(use_enable portaudio record-portaudio) \
		$(use_enable gstreamer record-gst) \
		$(use_enable alsa record-alsa) \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	keepdir "${GAMES_DATADIR}"/${PN}/songs
	if use songs; then
		insinto "${GAMES_DATADIR}"/${PN}
		doins -r ../songs || die "doins songs failed"
	fi
	mv "${D}${GAMES_DATADIR}"/{applications,pixmaps} "${D}"/usr/share/
	dodoc AUTHORS ChangeLog README TODO
	prepgamesdirs
}
