# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/xawtv/xawtv-3.19.ebuild,v 1.1 2000/08/25 15:10:24 achim Exp $

P=xawtv-3.19
A=xawtv_3.19.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="TV application for the bttv driver"
SRC_URI="http://www.strusel007.de/linux/xawtv/"${A}
HOMEPAGE="http://www.strusel007.de/linux/xawtv/"

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  ./configure --host=${CHOST} --prefix=/usr \
	--enable-jpeg --enable-xfree-ext --enable-xvideo --with-x
  make
}

src_install() {                               
  cd ${S}
  make prefix=${D}/usr install
  prepman
  dodoc COPYING Changes KNOWN_PROBLEMS Miro_gpio.txt Programming-FAQ
  dodoc README* Sound-FAQ TODO Trouble-Shooting UPDATE_TO_v3.0
  insinto /usr/local/httpd/cgi-bin
  insopts -m 755 
  doins webcam/webcam.cgi
  dodir /usr/X11R6/lib
  mv ${D}/usr/lib/X11 ${D}/usr/X11R6/lib
  rm -rf ${D}/usr/X11R6/lib/X11/fonts/misc/fonts.dir
  rm -rf ${D}/usr/lib
}





