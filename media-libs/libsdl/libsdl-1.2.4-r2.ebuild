# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsdl/libsdl-1.2.4-r2.ebuild,v 1.4 2002/07/16 11:36:48 seemant Exp $

S=${WORKDIR}/SDL-${PV}
DESCRIPTION="Simple Direct Media Layer"
SRC_URI="http://www.libsdl.org/release/SDL-${PV}.tar.gz"
HOMEPAGE="http://www.libsdl.org/"

RDEPEND=">=media-libs/audiofile-0.1.9
	X? ( virtual/x11 )
	esd? ( >=media-sound/esound-0.2.19 )
	ggi? ( >=media-libs/libggi-2.0_beta3 )
	nas? ( media-libs/nas )
	alsa? ( media-libs/alsa-lib )
	arts? ( kde-base/arts )
	svga? ( >=media-libs/svgalib-1.4.2 )
	opengl? ( virtual/opengl )
	directfb? ( >=dev-libs/DirectFB-0.9.7 )"

DEPEND="${RDEPEND}
	dev-lang/nasm"

SLOT="0"
LICENSE="LGPL"
KEYWORDS="x86 ppc"

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

	use directfb \
		&& myconf="${myconf} --enable-video-directfb" \
		|| myconf="${myconf} --disable-video-directfb"

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
