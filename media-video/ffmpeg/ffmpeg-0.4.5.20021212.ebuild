# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ffmpeg/ffmpeg-0.4.5.20021212.ebuild,v 1.3 2002/12/14 19:38:32 method Exp $

S=${WORKDIR}/ffmpeg
DESCRIPTION="Tool to manipulate and stream video files"
SRC_URI="http://www.tinkerland.org.uk/cvs-snapshots/old/ffmpeg-121202-cvs.tar.gz"
HOMEPAGE="http://ffmpeg.sourceforge.net/"

IUSE="mmx encode oggvorbis"

inherit flag-o-matic
filter-flags -fforce-addr

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc "

DEPEND="x86? ( dev-lang/nasm )
		encode? ( >=media-sound/lame-3.92 )
		oggvorbis? ( >=media-libs/libvorbis-1.0-r1 )"

src_compile() {
	local myconf

	use x86 && use mmx || myconf="--disable-mmx"
	use encode && myconf="${myconf} --enable-mp3lame"
	use oggvorbis && myconf="${myconf} --enable-vorbis"

	./configure ${myconf} || die
	make || die
}

src_install() {
	dobin ffmpeg ffserver
	dodoc doc/*
	insinto /etc
	doins doc/ffserver.conf
}
