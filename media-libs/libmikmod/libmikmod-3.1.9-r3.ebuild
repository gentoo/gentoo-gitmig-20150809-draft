# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmikmod/libmikmod-3.1.9-r3.ebuild,v 1.1 2001/04/20 02:16:03 achim Exp $

P=libmikmod-3.1.9
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="The boldest sound on the planet"
SRC_URI="http://mikmod.darkorb.net/libmikmod/"${A}

DEPEND="virtual/glibc
	alsa? ( >=media-libs/alsa-lib-0.5.9 )
	esd? ( >=media-sound/esound-0.2.19 )"


src_compile() {

  local myconf
  if [ "`use esd`" ]
  then
    myconf="--enable-eds"
  else
    myconf="--disable-esd"
  fi
  if [ "`use alsa`" ]
  then
    myconf="--enable-alsa"
  else
    myconf="--disable-alsa"
  fi
  if [ "`use oss`" ]
  then
    myconf="--enable-oss"
  else
    myconf="--disable-oss"
  fi

  try ./configure --host=${CHOST} --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info \
	$myconf
  try make

}

src_install() {

  try make DESTDIR=${D} install

  dodoc AUTHORS COPYING* NEWS PROBLEMS README TODO *.lsm
  docinto html
  dodoc docs/*.html
}




