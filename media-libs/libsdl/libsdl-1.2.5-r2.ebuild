# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsdl/libsdl-1.2.5-r2.ebuild,v 1.1 2003/04/14 05:42:21 seemant Exp $

IUSE="arts xv opengl fbcon aalib nas esd X svga ggi alsa"

S="${WORKDIR}/SDL-${PV}"
DESCRIPTION="Simple Direct Media Layer"
SRC_URI="http://www.libsdl.org/release/SDL-${PV}.tar.gz"
HOMEPAGE="http://www.libsdl.org/"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="~x86 ~alpha ~ppc ~sparc"

RDEPEND=">=media-libs/audiofile-0.1.9
	X? ( >=x11-base/xfree-4.3.0 )
	esd? ( >=media-sound/esound-0.2.19 )
	ggi? ( >=media-libs/libggi-2.0_beta3 )
	nas? ( media-libs/nas )
	alsa? ( media-libs/alsa-lib )
	arts? ( kde-base/arts )
	svga? ( >=media-libs/svgalib-1.4.2 )
	opengl? ( virtual/opengl )"
# This creates circular deps for the moment ... 
#	directfb? ( dev-libs/DirectFB )"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4.0.5
	x86? ( dev-lang/nasm )"

src_unpack() {
	unpack ${A}
	cd ${S}/src/video/directfb

	sed -i "s:DICAPS_ALL, ::" SDL_DirectFB_video.c

	# Patch to allow SDL apps to choose the BEST refresh rates for a given 
	# resolution in XFree86-4.3 instead of the worst one.
	cd ${S}
	use X && epatch ${FILESDIR}/${P}-xfree-4.3.patch.bz2
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
		&& myconf="--enable-esd" \
		|| myconf="--disable-esd"

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

	#use directfb \
	#	&& myconf="${myconf} --enable-video-directfb" \
		myconf="${myconf} --disable-video-directfb"

	use x86 \
		&& myconf="${myconf} --enable-nasm" \
		|| myconf="${myconf} --disable-nasm"

	if use nas || use alsa || use oss || use arts || use esd
	then
		myconf="${myconf} --enable-audio"
	else
		myconf="${myconf} --disable-audio"
	fi

	if use X || use xv || use ggi || use aalib || use svga || use fbcon || use opengl
	then
		myconf="${myconf} --enable-video-dummy"
	else
		myconf="${myconf} --disable-video"
	fi

	econf \
		--enable-joystick \
		--enable-cdrom \
		--enable-threads \
		--enable-timers \
		--enable-endian \
		--enable-file \
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
