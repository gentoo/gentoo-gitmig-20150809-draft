# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Authors Bruce Locke <blocke@shivan.org>, Martin Schlemmer <azarah@gentoo.org>
#         Donny Davies <woodchip@gentoo.org>
# /home/cvsroot/gentoo-x86/media-video/mplayer/mplayer-0.18_pre-r1.ebuild,v 1.1 2001/09/24 06:34:22 woodchip Exp

MY_P="MPlayer-0.50pre"
S=${WORKDIR}/${MY_P}?
A="${MY_P}1.tar.bz2 default.tar.bz2 mp-arial-iso-8859-1.zip"
DESCRIPTION="Media Player for Linux"
SRC_URI="ftp://mplayerhq.hu/MPlayer/releases/${A}
	 ftp://mplayerhq.hu/MPlayer/Skin/default.tar.bz2
	 ftp://mplayerhq.hu/MPlayer/releases/mp-arial-iso-8859-1.zip"
HOMEPAGE="http://www.mplayerhq.hu"

# Experimental USE flags dvd and decss
DEPEND="virtual/glibc
        dev-lang/nasm
        media-libs/win32codecs
	>=media-libs/divx4linux-20010824
        dvd? ( media-libs/libdvdread )
        decss? ( media-libs/libdvdcss )
	opengl? ( media-libs/mesa )
        sdl? ( media-libs/libsdl )
        ggi? ( media-libs/libggi )
        svga? ( media-libs/svgalib )
        X? ( virtual/x11 )
	gtk? ( x11-libs/gtk+ )
        esd? ( media-sound/esound )
        alsa? ( media-libs/alsa-lib )
	ogg? ( media-libs/libogg )"

RDEPEND="virtual/glibc
        media-libs/win32codecs
        >=media-libs/divx4linux-20010824
        dvd? ( media-libs/libdvdread )
        decss? ( media-libs/libdvdcss )
	opengl? ( media-libs/mesa )
        sdl? ( media-libs/libsdl )
        ggi? ( media-libs/libggi )
        svga? ( media-libs/svgalib )
        X? ( virtual/x11 )
        gtk? ( x11-libs/gtk+ )
	esd? ( media-sound/esound )
        alsa? ( media-libs/alsa-lib )
	ogg? ( media-libs/libogg )"



src_compile() {

	local myconf
	use 3dnow  || myconf="${myconf} --disable-3dnow --disable-3dnowex"
	use mmx    || myconf="${myconf} --disable-mmx --disable-mmx2"
	use X      || myconf="${myconf} --disable-x11 --disable-xv"
	use gtk    && myconf="${myconf} --enable-gui"
	use oss    || myconf="${myconf} --disable-ossaudio"
	use nls    || myconf="${myconf} --disable-nls"
	use opengl || myconf="${myconf} --disable-gl"
	use sdl    || myconf="${myconf} --disable-sdl"
	use ggi    || myconf="${myconf} --disable-ggi"
	use sse    || myconf="${myconf} --disable-sse"
	use svga   || myconf="${myconf} --disable-svga"
	use alsa   || myconf="${myconf} --disable-alsa"
	use esd    || myconf="${myconf} --disable-esd"
	use ogg    || myconf="${myconf} --disable-oggvorbis"
	use decss  && myconf="${myconf} --enable-css"

	./configure --mandir=/usr/share/man --prefix=/usr --host=${CHOST} ${myconf} || die
	make OPTFLAGS="${CFLAGS}" all || die
	
}

src_install() {

	make prefix=${D}/usr/share BINDIR=${D}/usr/bin install || die
	
	rm DOCS/*.1
	dodir /usr/share/doc/${PF}
	cp -a DOCS/* ${D}/usr/share/doc/${PF}

	# Install default skin
	if [ "`use gtk`" ] ; then
		insinto /usr/share/mplayer/Skin/default
		doins ${WORKDIR}/default/*
		# Permissions is fried by default
		chmod a+rx ${D}/usr/share/mplayer/Skin/default/
		chmod a+r ${D}/usr/share/mplayer/Skin/default/*
	fi

	# Install the font used by OSD and the gui
	dodir /usr/share/mplayer/fonts
	cp -a ${WORKDIR}/iso-8859-1/ ${D}/usr/share/mplayer/fonts
	dosym /usr/share/mplayer/fonts/iso-8859-1/arial-14/ /usr/share/mplayer/font

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
		elif [ "`use xv`" ] ; then
			video="xv"
                elif [ "`use dga`" ] ; then
                        video="dga"
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
		elif [ "`use aalib`" ] ; then
			video="aa"
		fi
	fi
	if [ "`use sdl`" ] ; then
		audio="sdl"
	elif [ "`use alsa`" ] ; then
		audio="alsa"
	elif [ "`use oss`" ] ; then
		audio="oss"
	fi
	sed -e "s/vo=xv/vo=${video}/" -e "s/ao=oss/ao=${audio}/" -e 's/include =/#include =/' ${S}/etc/example.conf > ${T}/mplayer.conf

	insinto /etc
	doins ${T}/mplayer.conf ${S}/etc/codecs.conf
	
}
