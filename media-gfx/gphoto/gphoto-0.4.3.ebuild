# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author AJ Lewis <aj@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gphoto/gphoto-0.4.3.ebuild,v 1.5 2001/06/04 10:34:15 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="free, redistributable digital camera software application"
SRC_URI="http://www.gphoto.net/dist/${A}"
HOMEPAGE="http://www.gphoto.org"

DEPEND="virtual/glibc
	>=media-libs/imlib-1.8
	>=media-gfx/imagemagick-4.1"
	

src_compile() {

   # -pipe does no work
   try CFLAGS=\"${CFLAGS/-pipe/}\" ./configure --prefix=/opt/gnome --sysconfdir=/etc/opt/gnome
   try make clean
   try make ${MAKEOPTS}
}

src_install() {
    try make prefix=${D}/opt/gnome --sysconfdir=${D}/etc/opd/gnome  install
    dodoc AUTHORS CONTACTS COPYING ChangeLog FAQ MANUAL NEWS* PROGRAMMERS \
	 README THANKS THEMES TODO
}

