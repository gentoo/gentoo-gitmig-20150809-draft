# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/ultrastar-ng/ultrastar-ng-0.1.4.ebuild,v 1.2 2007/07/06 21:26:33 mr_bones_ Exp $

inherit eutils games

MY_PN=UltraStar-ng
MY_P=${MY_PN}-${PV}

DESCRIPTION="SingStar GPL clone"
HOMEPAGE="http://sourceforge.net/projects/ultrastar-ng/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="novideo opengl xine"

RDEPEND=">=sci-libs/fftw-3
	gnome-base/librsvg
	media-libs/alsa-lib
	media-libs/sdl-image
	media-libs/sdl-gfx
	xine? ( media-libs/xine-lib )
	!xine? ( media-libs/gstreamer )
	opengl? (
		virtual/opengl
		virtual/glu
	)
	!novideo? ( media-libs/smpeg )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	if use opengl && ! built_with_use media-libs/libsdl opengl; then
		eerror "opengl flag set, but libsdl wasn't build with opengl support"
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
	egamesconf ${myconf} || die "egamesconf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	keepdir ${GAMES_DATADIR}/${PN}/songs
	mv "${D}${GAMES_DATADIR}"/{applications,pixmaps} "${D}"/usr/share/
	dodoc AUTHORS ChangeLog README TODO
	prepgamesdirs
}
