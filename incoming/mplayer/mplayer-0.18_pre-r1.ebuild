# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bruce A. Locke <blocke@shivan.org>
# /home/cvsroot/gentoo-x86/media-video/mplayer/mplayer-0.18_pre-r1.ebuild,v 1.5 2001/09/22 19:05:23 azarah Exp


MY_P="MPlayer-0.18pre"
S=${WORKDIR}/${MY_P}?
DESCRIPTION="Media Player for Linux"
SRC_URI="http://mp.dev.hu/MPlayer/releases/${MY_P}.tgz"
HOMEPAGE="http://mplayer.sourceforge.net"

DEPEND="opengl? ( media-libs/mesa ) sdl? ( media-libs/libsdl ) \
	ggi? ( media-libs/libggi ) svga? ( media-libs/svgalib ) \
	X? ( virtual/x11 ) esd? ( media-sound/esound ) \
	alsa? ( media-libs/alsa-lib ) \
	dev-lang/nasm media-libs/w32codecs"

RDEPEND="$DEPEND"


src_compile() {

  local myconf
  
  if [ -z "`use nls`" ] ; then
	myconf="${myconf} --disable-nls"
  fi

  if [ -z "`use opengl`" ] ; then
	myconf="${myconf} --disable-gl"
  fi

  if [ -z "`use sdl`" ] ; then
	myconf="${myconf} --disable-sdl"
  fi

  if [ -z "`use ggi`" ] ; then
	myconf="${myconf} --disable-ggi"
  fi

  if [ -z "`use mmx`" ] ; then
	myconf="${myconf} --disable-mmx --disable-mmx2"
  fi

  if [ -z "`use 3dnow`" ] ; then
	myconf="${myconf} --disable-3dnow --disable-3dnowex"
  fi

  if [ -z "`use sse`" ] ; then
	myconf="${myconf} --disable-sse"
  fi

  if [ -z "`use svga`" ] ; then
	myconf="${myconf} --disable-svga"
  fi

  if [ -z "`use X`" ] ; then
	myconf="${myconf} --disable-x11 --disable-xv"
  	myprefix="/usr"
  fi

  if [ -z "`use oss`" ] ; then
	myconf="${myconf} --disable-ossaudio"
  fi

  if [ -z "`use alsa`" ] ; then
	myconf="${myconf} --disable-alsa"
  fi

  if [ -z "`use esd`" ] ; then
	myconf="${myconf} --disable-esd"
  fi

  ./configure --mandir=/usr/share/man --prefix=/usr --host=${CHOST} ${myconf} || die

  make OPTFLAGS="${CFLAGS}" all || die

}

src_install() {
  make prefix=${D}/usr/share BINDIR=${D}/usr/bin install || die

  rm DOCS/*.1
  dodoc DOCS/*

  # Install a wrapper for mplayer to handle the codecs.conf
  mv ${D}/usr/bin/mplayer ${D}/usr/bin/mplayer-bin
  cp ${FILESDIR}/mplayer ${D}/usr/bin/mplayer
  chown root.root ${D}/usr/bin/mplayer
  chmod 755 ${D}/usr/bin/mplayer

  # Try to get a basic mplayer.conf going
  local video
  local audio

  # Just incase we dont get a valid config
  video="sdl"
  audio="sdl"

  # Try to get a usuable -vo config
  if [ -n "`use X`" ] ; then
  	if [ -n "`use sdl`" ] ; then
		video="sdl"
		
	elif [ -n "`use ggi`" ] ; then
		video="ggi"

	elif [ -n "`use opengl`" ] ; then
  	 	video="gl"

	else
		video="x11"
	fi
  else
	if [ -n "`use fbcon`" ] ; then
		video="fbdev"
  
	elif [ -n "`use svga`" ] ; then
		video="svga"
	fi
  fi

  # Try to get a usable -ao config
  if [ -n "`use sdl`" ] ; then
  	audio="sdl"

  elif [ -n "`use alsa`" ] ; then
  	audio="alsa5"

  elif [ -n "`use oss`" ] ; then
  	audio="oss"
  fi

  sed -e "s/vo=sdl/vo=${video}/" -e "s/ao=sdl/ao=${audio}/" ${FILESDIR}/mplayer.conf >mplayer.conf
  
  dodir /etc
  cp mplayer.conf ${D}/etc/mplayer.conf
  cp ${FILESDIR}/codecs.conf ${D}/etc/codecs.conf
  chmod 644 ${FILESDIR}/codecs.conf ${D}/etc/codecs.conf

}

