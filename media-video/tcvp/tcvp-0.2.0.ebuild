# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/tcvp/tcvp-0.2.0.ebuild,v 1.8 2005/05/28 07:48:38 lu_zero Exp $

DESCRIPTION="A modular player and encoder/transcoder for music and video."
HOMEPAGE="http://tcvp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~x86 ~ppc"

IUSE="aac mpeg mad alsa dvd encode ffmpeg ogg vorbis oss"

DEPEND=">=dev-libs/libtc-1.1.0
	>=dev-libs/tc2-0.6.0
	>=dev-libs/tc2-modules-0.6.0
	>=media-libs/a52dec-0.7.4
	>=media-sound/cdparanoia-3.9.8-r1
	>=sys-apps/file-4.0
	aac? ( media-libs/faad2 )
	alsa? ( >=media-libs/alsa-lib-1.0.3b-r2 )
	dvd? ( >=media-libs/libdvdnav-0.1.9 )
	encode? ( >=media-libs/faac-1.23.5
		>=media-sound/lame-3.96 )
	ffmpeg? ( >=media-video/ffmpeg-0.4.8 )
	mad? ( >=media-sound/madplay-0.15.2b )
	mpeg? ( >=media-libs/libmpeg2-0.4.0b )
	ogg?  ( >=media-libs/libogg-1.1 )
	vorbis? ( >=media-libs/libvorbis-1.0.1-r2 )"

src_compile() {
	local myconf
	myconf="--with-gnu-ld"
	use alsa || myconf="${myconf} --disable-alsa"
	use dvd || myconf="${myconf} --disable-dvd"
	use encode || myconf="${myconf} --disable-lame --disable-aac_enc"
	use ffmpeg || myconf="${myconf} --disable-avcodec --disable-avformat --disable-avimage --disable-scale"
	use mad || myconf="${myconf} --disable-mad"
	use mpeg || myconf="${myconf} --disable-mpeg2"
	if ! use vorbis
	then 
	myconf="${myconf} --disable-vorbis"
	use ogg || myconf="${myconf} --disable-ogg"
	fi
	use oss || myconf="${myconf} --disable-oss"
	econf ${myconf} || die "configure failed"
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING
}
