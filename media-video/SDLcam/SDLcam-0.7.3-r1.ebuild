# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/SDLcam/SDLcam-0.7.3-r1.ebuild,v 1.2 2004/01/30 12:32:52 mr_bones_ Exp $

inherit eutils

DESCRIPTION="Webcam application that uses the SDL library"
HOMEPAGE="http://raph.darktech.org/SDLcam/"
SRC_URI="http://raph.darktech.org/SDLcam/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="dev-libs/libxml2
	media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-ttf"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gcc3.patch
	epatch ${FILESDIR}/${PV}-no-divx.patch
	rm capture/divx.c   # the divx.so needs to be ported to newer avifile
	epatch ${FILESDIR}/${PV}-linux-2.6.patch
	sed -i "s: -g: ${CFLAGS} `avifile-config --cflags`:" Makefile
	sed -i "/#include/s:avifile/::" capture/divx2.cpp

	# Don't you love hardcoded vars?
	sed -i \
		-e 's:/usr/local/share/SDLcam/:/usr/share/SDLcam/:' \
		-e 's:/usr/local/lib/SDLcam:/usr/lib/SDLcam:' \
		-e 's:sources/:/usr/lib/SDLcam/sources/:' \
		configuration.h interface.cpp SDL_v4l_filters.c main.cpp
}

src_compile() {
	emake || die
}

src_install () {
	dobin SDLcam
	insinto /usr/share/SDLcam
	doins LucidaSansRegular.ttf LucidaTypewriterRegular.ttf SDLcam.xml SDLcam.cfg
	insinto /usr/lib/SDLcam/filters
	doins filter/*.so
	insinto /usr/lib/SDLcam/capture
	doins capture/*.so
	insinto /usr/lib/SDLcam/sources
	doins sources/*.so
}
