# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/SDLcam/SDLcam-0.8.0.ebuild,v 1.1 2007/10/06 13:05:41 vapier Exp $

inherit eutils multilib

DESCRIPTION="webcam application that uses the SDL library"
HOMEPAGE="http://sdlcam.raphnet.net/"
SRC_URI="http://sdlcam.raphnet.net/downloads/sdlcam-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-libs/libxml2
	media-libs/jpeg
	media-libs/libpng
	media-libs/libfame
	media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-ttf"

S=${WORKDIR}/sdlcam-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm config.log config.status Makefile config.h || die
	epatch "${FILESDIR}"/${PN}-0.7.3-tsc.patch #109161
	epatch "${FILESDIR}"/${PN}-0.7.3-prototypes.patch
	epatch "${FILESDIR}"/${P}-build.patch
	epatch "${FILESDIR}"/${PN}-0.7.3-jpeg.patch

	# Don't you love hardcoded vars?
	sed -i \
		-e 's:/usr/local/share/SDLcam/:/usr/share/SDLcam/:' \
		-e 's:/usr/local/lib/SDLcam:/usr/$(get_libdir)/SDLcam:' \
		-e 's:sources/:/usr/$(get_libdir)/SDLcam/sources/:' \
		configuration.h interface.cpp SDL_v4l_filters.c main.cpp
}

src_install() {
	dobin SDLcam || die
	insinto /usr/share/SDLcam
	doins LucidaSansRegular.ttf LucidaTypewriterRegular.ttf SDLcam.xml SDLcam.cfg || die
	exeinto /usr/$(get_libdir)/SDLcam/filters
	doexe filter/*.so || die
	exeinto /usr/$(get_libdir)/SDLcam/capture
	doexe capture/*.so || die
	exeinto /usr/$(get_libdir)/SDLcam/sources
	doexe sources/*.so || die
}
