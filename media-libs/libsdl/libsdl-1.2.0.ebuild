# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsdl/libsdl-1.2.0.ebuild,v 1.3 2001/06/10 15:23:47 drobbins Exp $

A=SDL-${PV}.tar.gz
S=${WORKDIR}/SDL-${PV}
DESCRIPTION="Simple Direct Media Layer"
SRC_URI="http://www.libsdl.org/release/${A}"
HOMEPAGE="http://www.libsdl.org/"

DEPEND="virtual/glibc
    >=dev-lang/nasm-0.98
    >=media-libs/audiofile-0.1.9
    opengl? ( virtual/opengl )
    svga? ( >=media-libs/svgalib-1.4.2 )
    esd? ( >=media-sound/esound-0.2.19 )
    X? ( virtual/x11 )
    arts? ( >=kde-base/kdelibs-2.0.1 )
    nas? ( media-sound/nas )
    ggi? ( >=media-libs/libggi-2.0_beta3 )
	alsa? ( media-libs/alsa-lib )"

RDEPEND="virtual/glibc
    >=media-libs/audiofile-0.1.9
    opengl? ( virtual/opengl )
    svga? ( >=media-libs/svgalib-1.4.2 )
    esd? ( >=media-sound/esound-0.2.19 )
    X? ( virtual/x11 )
    arts? ( >=kde-base/kdelibs-2.0.1 )
    nas? ( media-sound/nas )
    ggi? ( >=media-libs/libggi-2.0_beta3 )
	alsa? ( media-libs/alsa-lib )"

src_compile() {

  local myconf

  if [ -z "`use esd`" ]
  then
    myconf="--disable-esd"
  else
  	myconf="--enable-esd"
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
  if [ -n "`use alsa`" ]
  then
    myconf="${myconf} --enable-alsa"
  else
    myconf="${myconf} --disable-alsa"
  fi	

  try ./configure --host=${CHOST} --prefix=/usr --mandir=/usr/share/man ${myconf}

  try make

}

src_install() {
  cd ${S}
  try make DESTDIR=${D} install
  preplib /usr
  dodoc BUGS COPYING CREDITS README* TODO WhatsNew
  docinto html
  dodoc *.html
  docinto html/docs
  dodoc docs/*.html
  
}
pkg_postinst() {

 ldconfig -r ${ROOT}

}



