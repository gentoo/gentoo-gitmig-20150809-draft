# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/imlib2/imlib2-1.0.3-r1.ebuild,v 1.1 2001/10/06 10:38:04 azarah Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="imlib"
SRC_URI="http://prdownloads.sourceforge.net/enlightenment/${A}"
HOMEPAGE="http://enlightenment.org/"

DEPEND="virtual/glibc
	>=media-libs/giflib-4.1.0
	>=media-libs/libpng-1.0.7
	>=media-libs/tiff-3.5.5
	<=media-libs/freetype-1.4
	>=x11-libs/gtk+-1.2.10-r4
	dev-db/edb
	virtual/x11"

src_compile() {
  try  ./configure --host=${CHOST} --prefix=/usr --sysconfdir=/etc/X11/imlib
  try make
}

src_install() {
  try make prefix=${D}/usr sysconfdir=${D}/etc/X11/imlib install
  preplib /usr
  dodoc AUTHORS COPYING* ChangeLog README
  docinto html
  dodoc doc/*.gif doc/index.html
}



