# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/tcvp/tcvp-0.2.0.ebuild,v 1.3 2004/06/09 18:23:24 dholm Exp $

DESCRIPTION="TCVP is a modular player and encoder/transcoder for music and video."
HOMEPAGE="http://tcvp.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~x86 ~ppc"

IUSE="alsa cdr dvd encode ffmpeg oggvorbis oss static"

RDEPEND="virtual/x11
	>=media-libs/freetype-2.1.5-r1
	>=media-libs/audiofile-0.2.5
	>=media-libs/libmpeg2-0.4.0b
	>=media-sound/madplay-0.15.2b
	>=dev-libs/libtc-1.1.0
	>=dev-libs/tc2-0.6.0
	>=dev-libs/tc2-modules-0.6.0
	>=media-libs/faac-1.23.5
	alsa? ( >=media-libs/alsa-lib-1.0.3b-r2 )
	encode? ( >=media-sound/lame-3.96 )
	oggvorbis? ( >=media-libs/libogg-1.1
		    >=media-libs/libvorbis-1.0.1-r2 )
	ffmpeg? ( >=media-video/ffmpeg-0.4.8 )
	cdr? ( >=media-sound/cdparanoia-3.9.8-r1 )
	dvd? ( >=media-libs/libdvdread-0.9.4
		>=media-libs/a52dec-0.7.4 )"

src_compile() {
	local myconf
	myconf="--with-gnu-ld"
	use static && myconf="${myconf} --enable-static"
	use alsa || myconf="${myconf} --disable-alsa"
	use encode || myconf="${myconf} --disable-lame"
	use dvd || myconf="${myconf} --disable-dvd --disable-a52"
	use oss || myconf="${myconf} --disable-oss"
	econf ${myconf} || die "configure failed"
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING
}


