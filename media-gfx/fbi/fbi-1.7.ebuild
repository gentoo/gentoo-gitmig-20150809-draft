# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ryan Tolboom <ryan@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/fbi/fbi-1.7.ebuild,v 1.2 2001/05/29 17:28:19 achim Exp $

A=fbi_1.7.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="fbi a framebuffer image viewer"
SRC_URI="http://www.strusel007.de/linux/misc/"${A}
HOMEPAGE="http://www.strusel007.de/linux/fbi.html"

DEPEND=">=media-libs/jpeg-6b"

src_unpack() {
  unpack ${A}
  cd ${S}/src
  cp Makefile Makefile.orig
  sed -e "s:-O2:$CFLAGS:" Makefile.orig > Makefile
  cd ${S}/libpcd
  cp Makefile Makefile.orig
  sed -e "s:-O2:$CFLAGS:" Makefile.orig > Makefile

}

src_compile() {

	try make
}

src_install() {

	dodoc README
	dobin src/fbi
	newman src/fbi.man fbi.1
}
