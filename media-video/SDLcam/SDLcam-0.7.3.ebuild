# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/SDLcam/SDLcam-0.7.3.ebuild,v 1.5 2003/02/28 16:55:00 liquidx Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="Webcam application that uses the SDL library"
HOMEPAGE="http://raph.darktech.org/SDLcam/"
SRC_URI="http://raph.darktech.org/SDLcam/downloads/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

DEPEND="dev-libs/libxml2
	media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-ttf"


src_compile() {

	# Don't you love hardcoded vars?
	mv configuration.h configuration.h.orig
	sed "s:/usr/local/share/SDLcam/:/usr/share/SDLcam/:" \
		configuration.h.orig > configuration.h
	mv interface.cpp interface.cpp.orig
	sed "s:/usr/local/share/SDLcam:/usr/share/SDLcam:" \
		interface.cpp.orig > interface.cpp
	mv SDL_v4l_filters.c SDL_v4l_filters.c.orig
	sed "s:/usr/local/lib/SDLcam:/usr/lib/SDLcam:" \
		SDL_v4l_filters.c.orig > SDL_v4l_filters.c
	emake || die
}

src_install () {
	dobin SDLcam
	insinto /usr/share/SDLcam
	doins LucidaSansRegular.ttf LucidaTypewriterRegular.ttf SDLcam.xml SDLcam.cfg
	insinto /usr/lib/SDLcam/filters
	doins ${S}/filter/*.so
	insinto /usr/lib/SDLcam/capture
	doins ${S}/capture/*.so
}
