# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/ultrastar-ng/ultrastar-ng-0.2.1-r1.ebuild,v 1.6 2009/02/09 18:38:01 mr_bones_ Exp $

EAPI=2
inherit eutils games

MY_PN=UltraStar-ng
MY_P=${MY_PN}-${PV}
SONGS_PN=ultrastar-songs
SONGS_P=${SONGS_PN}-2

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
IUSE="+video opengl xine debug alsa gstreamer portaudio +songs"

RDEPEND="gnome-base/librsvg
	>=dev-libs/boost-1.34
	x11-libs/pango
	media-libs/libsdl[opengl?]
	media-libs/sdl-image[jpeg,png]
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
	video? ( media-libs/smpeg )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

src_configure() {
	local myconf

	if use video; then
		myconf="--with-video=smpeg"
	else
		myconf="--with-video=disable"
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
		$(use_enable alsa record-alsa)
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
