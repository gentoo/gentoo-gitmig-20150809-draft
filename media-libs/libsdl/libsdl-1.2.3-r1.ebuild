# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsdl/libsdl-1.2.3-r1.ebuild,v 1.5 2002/08/26 12:13:52 seemant Exp $

S=${WORKDIR}/SDL-${PV}
DESCRIPTION="Simple Direct Media Layer"
SRC_URI="http://www.libsdl.org/release/SDL-${PV}.tar.gz"
HOMEPAGE="http://www.libsdl.org/"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86"

DEPEND=">=dev-lang/nasm-0.98
	>=media-libs/audiofile-0.1.9
	opengl? ( virtual/opengl )
	svga? ( >=media-libs/svgalib-1.4.2 )
	esd? ( >=media-sound/esound-0.2.19 )
	X? ( virtual/x11 )
	arts? ( >=kde-base/kdelibs-2.0.1 )
	nas? ( media-libs/nas )
	ggi? ( >=media-libs/libggi-2.0_beta3 )
	alsa? ( media-libs/alsa-lib )
	directfb? ( >=dev-libs/DirectFB-0.9.7 )"

src_compile() {
	local myconf
	if [ -z "`use esd`" ]
	then
		myconf="--disable-esd"
	else
		myconf="--enable-esd"
	fi
	if [ -z "`use xv`" ]
	then
		myconf="${myconf} --disable-video-x11-xv"
	else
		myconf="${myconf} --enable-video-x11-xv"
	fi
	if [ -z "`use arts`" ]
	then
		myconf="${myconf} --disable-arts"
	else
		myconf="${myconf} --enable-arts"
	fi
	
	if [ -z "`use nas`" ]
	then
		myconf="${myconf} --disable-nas"
	else
		myconf="${myconf} --enable-nas"
	fi
	if [ -z "`use X`" ]
	then
		myconf="${myconf} --disable-video-x11"
	else
		myconf="${myconf} --enable-video-x11"
	fi
	if [ "`use svga`" ]
	then
		myconf="${myconf} --enable-video-svga"
	else
		myconf="${myconf} --disable-video-svga"
	fi
	if [ -z "`use fbcon`" ]
	then
		myconf="${myconf} --disable-video-fbcon"
	else
		myconf="${myconf} --enable-video-fbcon"
	fi
	if [ "`use aalib`" ]
	then
		myconf="${myconf} --enable-video-aalib"
	else
		myconf="${myconf} --disable-video-aalib"
	fi
	if [ "`use ggi`" ]
	then
		myconf="${myconf} --enable-video-ggi"
	else
		myconf="${myconf} --disable-video-ggi"
	fi
	if [ -z "`use opengl`" ]
	then
		myconf="${myconf} --disable-video-opengl"
	else
		myconf="${myconf} --enable-video-opengl"
	fi
	if [ -z "`use directfb`" ]
	then
		myconf="${myconf} --disable-video-directfb"
	else
		myconf="${myconf} --enable-video-directfb"
	fi
	if [ -n "`use alsa`" ]
	then
		myconf="${myconf} --enable-alsa"
	else
		myconf="${myconf} --disable-alsa"
	fi	
	./configure --host=${CHOST} --enable-input-events --prefix=/usr --mandir=/usr/share/man ${myconf} || die
	emake || die
}

src_install() {
	cd ${S}
	make DESTDIR=${D} install || die
	preplib /usr
	dodoc BUGS COPYING CREDITS README* TODO WhatsNew
	docinto html
	dodoc *.html
	docinto html/docs
	dodoc docs/*.html
}
