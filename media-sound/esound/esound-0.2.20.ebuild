# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/esound/esound-0.2.20.ebuild,v 1.1 2000/11/25 13:13:30 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="esound"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/esound/"${A}
HOMEPAGE="http://www.tux.org/~ricdude/EsounD.html"

DEPEND=">=sys-apps/bash-2.04
	>=sys-libs/glibc-2.1.3
	>=media-libs/alsa-lib-0.5.9
	>=media-libs/audiofile-0.1.9"

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/usr \
		  --sysconfdir=/etc/esd --with-libwrap
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






