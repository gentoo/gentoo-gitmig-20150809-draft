# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/xawtv/xawtv-3.45.ebuild,v 1.1 2001/05/08 00:24:40 achim Exp $

A=xawtv_${PV}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="TV application for the bttv driver"
SRC_URI="http://www.strusel007.de/linux/xawtv/${A}"
HOMEPAGE="http://www.strusel007.de/linux/xawtv/"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.1
	>=media-libs/jpeg-6b
        >=media-libs/libpng-1.0.8
	>=x11-base/xfree-4.0.1"

src_compile() {

  unset DEPEND
  try ./configure --host=${CHOST} --prefix=/usr \
	--enable-jpeg --enable-xfree-ext --enable-xvideo --with-x
  try make
}

src_install() {

  try make prefix=${D}/usr mandir=${D}/usr/share/man install

  dodoc COPYING Changes KNOWN_PROBLEMS Miro_gpio.txt Programming-FAQ
  dodoc README* Sound-FAQ TODO Trouble-Shooting UPDATE_TO_v3.0
  insinto /usr/local/httpd/cgi-bin
  insopts -m 755
  doins webcam/webcam.cgi

}






