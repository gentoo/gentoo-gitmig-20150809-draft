# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/SDLcam/SDLcam-0.7.3-r2.ebuild,v 1.3 2006/10/22 05:36:10 vapier Exp $

inherit eutils

DESCRIPTION="Webcam application that uses the SDL library"
HOMEPAGE="http://sdlcam.raphnet.net/"
SRC_URI="http://sdlcam.raphnet.net/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="dev-libs/libxml2
	media-libs/libfame
	media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-ttf"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-gcc3.patch
	rm capture/divx*   # the divx.so needs to be ported to newer avifile
	epatch "${FILESDIR}"/${PV}-linux-2.6.patch
	epatch "${FILESDIR}"/${P}-tsc.patch #109161
	epatch "${FILESDIR}"/${P}-prototypes.patch
	epatch "${FILESDIR}"/${P}-build.patch
	epatch "${FILESDIR}"/${P}-relax-asm.patch #152002
	epatch "${FILESDIR}"/${P}-jpeg.patch
	sed -i "/#include/s:avifile/::" capture/divx2.cpp

	# Don't you love hardcoded vars?
	sed -i \
		-e 's:/usr/local/share/SDLcam/:/usr/share/SDLcam/:' \
		-e 's:/usr/local/lib/SDLcam:/usr/lib/SDLcam:' \
		-e 's:sources/:/usr/lib/SDLcam/sources/:' \
		configuration.h interface.cpp SDL_v4l_filters.c main.cpp
}

src_install() {
	dobin SDLcam || die
	insinto /usr/share/SDLcam
	doins LucidaSansRegular.ttf LucidaTypewriterRegular.ttf SDLcam.xml SDLcam.cfg || die
	insinto /usr/lib/SDLcam/filters
	doins filter/*.so || die
	insinto /usr/lib/SDLcam/capture
	doins capture/*.so || die
	insinto /usr/lib/SDLcam/sources
	doins sources/*.so || die
}
