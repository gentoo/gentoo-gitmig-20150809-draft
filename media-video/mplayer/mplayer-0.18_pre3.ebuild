# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bruce A. Locke <blocke@shivan.org>

MY_P="MPlayer-0.18pre3"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Media Player for Linux"
SRC_URI="http://mplayerhq.banki.hu/MPlayer/releases/${MY_P}.tgz"
HOMEPAGE="http://mplayer.sourceforge.net"

DEPEND="media-video/avifile"

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
  fi

  if [ -z "`use oss`" ] ; then
	myconf="${myconf} --disable-ossaudio"
  fi

  if [ -z "`use alsa`"] ; then
	myconf="${myconf} --disable-alsa"
  fi

  if [ -z "`use esd`" ] ; then
	myconf="${myconf} --disable-esd"
  fi

  try ./configure --prefix=/usr --host=${CHOST} ${myconf}

  try make OPTFLAGS=\"${CFLAGS}\" all
}

src_install() {


  make prefix=${D}/usr install

  rm ${S}/DOCS/*.1
  dodoc DOCS/*

}

