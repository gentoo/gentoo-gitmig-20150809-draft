# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bruce A. Locke <blocke@shivan.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/mplayer/mplayer-0.18_pre.ebuild,v 1.4 2001/08/31 03:23:39 pm Exp $


MY_P="MPlayer-0.18pre"
S=${WORKDIR}/${MY_P}?
DESCRIPTION="Media Player for Linux"
SRC_URI="http://mp.dev.hu/MPlayer/releases/${MY_P}.tgz"
HOMEPAGE="http://mplayer.sourceforge.net"

DEPEND="opengl? ( media-libs/mesa ) sdl? ( media-libs/libsdl ) \
	ggi? ( media-libs/libggi ) svga? ( media-libs/svgalib ) \
	X? ( virtual/x11 ) esd? ( media-sound/esound ) \
	alsa? ( media-libs/alsa-lib )"

RDEPEND="$DEPEND"


src_compile() {

  local myconf
  local myprefix
  myprefix="/usr/X11R6"
  
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

  try ./configure --mandir=/usr/share/man --prefix=`cat ${T}/myprefix` --host=${CHOST} ${myconf}

  try make OPTFLAGS="${CFLAGS}" all

  echo "${myprefix}" > ${T}/myprefix

}

src_install() {
  make prefix=${D}/`cat ${T}/myprefix` install

  if [ -f ${D}/usr/X11R6/bin/fibmap_mplayer ] ; then
	dodir /usr/bin
	mv ${D}/usr/X11R6/bin/fibmap_mplayer ${D}/usr/bin
  fi

  rm DOCS/*.1
  dodoc DOCS/*
}

