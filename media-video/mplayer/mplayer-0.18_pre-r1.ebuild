# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Authors Bruce Locke <blocke@shivan.org>, Martin Schlemmer <azarah@saintmail.net>
#         Donny Davies <woodchip@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/mplayer/mplayer-0.18_pre-r1.ebuild,v 1.1 2001/09/24 06:34:22 woodchip Exp $

MY_P="MPlayer-0.18pre"
S=${WORKDIR}/${MY_P}?
DESCRIPTION="Media Player for Linux"
SRC_URI="http://mp.dev.hu/MPlayer/releases/${MY_P}.tgz"
HOMEPAGE="http://mplayer.sourceforge.net"

DEPEND="virtual/glibc
        dev-lang/nasm
        media-libs/win32codecs
        opengl? ( media-libs/mesa )
        sdl? ( media-libs/libsdl )
        ggi? ( media-libs/libggi )
        svga? ( media-libs/svgalib )
        X? ( virtual/x11 )
        esd? ( media-sound/esound )
        alsa? ( media-libs/alsa-lib )"

RDEPEND="virtual/glibc
         media-libs/win32codecs
         opengl? ( media-libs/mesa )
         sdl? ( media-libs/libsdl )
         ggi? ( media-libs/libggi )
         svga? ( media-libs/svgalib )
         X? ( virtual/x11 )
         esd? ( media-sound/esound )
         alsa? ( media-libs/alsa-lib )"

src_compile() {
	local myconf
	use 3dnow  || myconf="${myconf} --disable-3dnow --disable-3dnowex"
	use mmx    || myconf="${myconf} --disable-mmx --disable-mmx2"
	use X      || myconf="${myconf} --disable-x11 --disable-xv"
	use oss    || myconf="${myconf} --disable-ossaudio"
	use nls    || myconf="${myconf} --disable-nls"
	use opengl || myconf="${myconf} --disable-gl"
	use sdl    || myconf="${myconf} --disable-sdl"
	use ggi    || myconf="${myconf} --disable-ggi"
	use sse    || myconf="${myconf} --disable-sse"
	use svga   || myconf="${myconf} --disable-svga"
	use alsa   || myconf="${myconf} --disable-alsa"
	use esd    || myconf="${myconf} --disable-esd"

	./configure --mandir=/usr/share/man --prefix=/usr --host=${CHOST} ${myconf} || die
	make OPTFLAGS="${CFLAGS}" all || die
}

src_install() {
	make prefix=${D}/usr/share BINDIR=${D}/usr/bin install || die
	mkdir -p ${D}/usr/share/doc/${PF}
	cp -a DOCS/* ${D}/usr/share/doc/${PF}

	# Install a wrapper for mplayer to handle the codecs.conf
	mv ${D}/usr/bin/mplayer ${D}/usr/bin/mplayer-bin
	exeinto /usr/bin ; doexe ${FILESDIR}/mplayer

	# This tries setting up mplayer.conf automagically
	local video="sdl" audio="sdl"
	if [ "`use X`" ] ; then
		if [ "`use sdl`" ] ; then
			video="sdl"
		elif [ "`use ggi`" ] ; then
			video="ggi"
		elif [ "`use opengl`" ] ; then
			video="gl"
		else
			video="x11"
		fi
	else
		if [ "`use fbcon`" ] ; then
			video="fbdev"
		elif [ "`use svga`" ] ; then
			video="svga"
		fi
	fi
	if [ "`use sdl`" ] ; then
		audio="sdl"
	elif [ "`use alsa`" ] ; then
		audio="alsa"
	elif [ "`use oss`" ] ; then
		audio="oss"
	fi
	sed -e "s/vo=sdl/vo=${video}/" -e "s/ao=sdl/ao=${audio}/" ${FILESDIR}/mplayer.conf > mplayer.conf

	insinto /etc
	doins mplayer.conf ${FILESDIR}/codecs.conf
}
