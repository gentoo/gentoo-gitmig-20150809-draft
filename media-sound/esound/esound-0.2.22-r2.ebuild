# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/esound/esound-0.2.22-r2.ebuild,v 1.1 2001/04/21 04:27:00 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="esound"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/esound/${A}
           ftp://download.sourceforge.net/pub/mirrors/gnome/stable/sources/esound/${A}"
HOMEPAGE="http://www.tux.org/~ricdude/EsounD.html"

DEPEND="virtual/glibc
	alsa? ( >=media-libs/alsa-lib-0.5.9 )
	>=media-libs/audiofile-0.1.9
    tcpd? ( >=sys-apps/tcp-wrappers-7.6-r2 )"

RDEPEND="virtual/glibc
	alsa? ( >=media-libs/alsa-lib-0.5.9 )
	>=media-libs/audiofile-0.1.9"

src_compile() {                           

  local myconf
  if [ "`use tcpd`" ]
  then
    myconf="--with-libwrap"
  else
    myconf="--without-libwrap"
  fi

  if [ "`use alsa`" ]
  then
    myconf="$myconf --enable-alsa"
  else
    myconf="$myconf --enable-alsa=no"
  fi

  try ./configure --host=${CHOST} --prefix=/usr \
		  --sysconfdir=/etc/esd $myconf
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/usr sysconfdir=${D}/etc/esd install
  dodoc AUTHORS COPYING* ChangeLog README TODO
  dodoc NEWS TIPS
  dodoc docs/esound.ps
  docinto html
  dodoc docs/html/*.html docs/html/*.css
  docinto html/stylesheet-images
  dodoc docs/html/stylesheet-images/*.gif
}






