# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsdl/libsdl-1.2.4.20020601.ebuild,v 1.14 2003/06/11 22:11:12 mholzer Exp $

IUSE="arts xv opengl fbcon aalib nas esd X svga ggi alsa directfb"

S=${WORKDIR}/SDL12
DESCRIPTION="Simple Direct Media Layer"
SRC_URI="http://www.libsdl.org/release/${P}.tar.bz2"
HOMEPAGE="http://www.libsdl.org/"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 ppc sparc"

RDEPEND=">=media-libs/audiofile-0.1.9
	X? ( virtual/x11 )
	esd? ( >=media-sound/esound-0.2.19 )
	ggi? ( >=media-libs/libggi-2.0_beta3 )
	nas? ( media-libs/nas )
	alsa? ( media-libs/alsa-lib )
	arts? ( kde-base/arts )
	svga? ( >=media-libs/svgalib-1.4.2 )
	opengl? ( virtual/opengl )
	directfb? ( >=dev-libs/DirectFB-0.9.11 )"

DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )"

src_unpack() {

	unpack ${A}
	cd ${S}/src/video/directfb
	cp SDL_DirectFB_events.c SDL_DirectFB_events.c.orig
	sed -e "s:DIKI_CTRL:DIKI_CONTROL_L:" \
		-e "s:DIKI_SHIFT:DIKI_SHIFT_L:" \
		-e "s:DIKI_ALT:DIKI_ALT_L:" \
		-e "s:DIKI_ALT_LGR:DIKI_ALT_R:" \
		-e "s:DIKI_CAPSLOCK:DIKI_CAPS_LOCK:" \
		-e "s:DIKI_NUMLOCK:DIKI_NUM_LOCK:" \
		-e "s:DIKI_SCRLOCK:DIKI_SCROLL_LOCK:" \
		SDL_DirectFB_events.c.orig > SDL_DirectFB_events.c
}

src_compile() {
	local myconf

	use X \
		&& myconf="${myconf} --enable-video-x11" \
		|| myconf="${myconf} --disable-video-x11"

	use xv \
		&& myconf="${myconf} --enable-video-x11-xv" \
		|| myconf="${myconf} --disable-video-x11-xv"

	use esd \
		&& myconf="${myconf} --enable-esd" \
		|| myconf="${myconf} --disable-esd"

	use ggi \
		&& myconf="${myconf} --enable-video-ggi" \
		|| myconf="${myconf} --disable-video-ggi"

	use nas \
		&& myconf="${myconf} --enable-nas" \
		|| myconf="${myconf} --disable-nas"

	use alsa \
		&& myconf="${myconf} --enable-alsa" \
		|| myconf="${myconf} --disable-alsa"

	use arts \
		&& myconf="${myconf} --enable-arts" \
		|| myconf="${myconf} --disable-arts"
	
	use svga \
		&& myconf="${myconf} --enable-video-svga" \
		|| myconf="${myconf} --disable-video-svga"

	use aalib \
		&& myconf="${myconf} --enable-video-aalib" \
		|| myconf="${myconf} --disable-video-aalib"

	use fbcon \
		&& myconf="${myconf} --enable-video-fbcon" \
		|| myconf="${myconf} --disable-video-fbcon"

	use opengl \
		&& myconf="${myconf} --enable-video-opengl" \
		|| myconf="${myconf} --disable-video-opengl"

	use directfb \
		&& myconf="${myconf} --enable-video-directfb" \
		|| myconf="${myconf} --disable-video-directfb"

	./autogen.sh

	./configure \
		--host=${CHOST} \
		--enable-input-events \
		--prefix=/usr \
		--mandir=/usr/share/man \
		${myconf} || die

	emake || die
}

src_install() {
	make \
		DESTDIR=${D} \
		install || die

	preplib /usr
	dodoc BUGS COPYING CREDITS README* TODO WhatsNew
	dohtml -r ./
}
