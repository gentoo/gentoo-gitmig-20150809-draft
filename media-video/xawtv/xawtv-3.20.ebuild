# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/xawtv/xawtv-3.20.ebuild,v 1.3 2000/11/02 08:31:51 achim Exp $

A=xawtv_3.20.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="TV application for the bttv driver"
SRC_URI="http://www.strusel007.de/linux/xawtv/"${A}
HOMEPAGE="http://www.strusel007.de/linux/xawtv/"

DEPEND=">=sys-libs/glibc-2.1.3
	>=sys-libs/gpm-1.19.3
	>=sys-libs/ncurses-5.1
	>=media-libs/jpeg-6b
	>=x11-base/xfree-4.0.1"

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/usr \
	--enable-jpeg --enable-xfree-ext --enable-xvideo --with-x
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/usr install
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






