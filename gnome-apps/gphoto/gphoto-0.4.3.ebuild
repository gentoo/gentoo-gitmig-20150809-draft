# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author AJ Lewis <aj@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-apps/gphoto/gphoto-0.4.3.ebuild,v 1.1 2001/05/06 18:24:16 aj Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="free, redistributable digital camera software application"
SRC_URI="http://www.gphoto.net/dist/${A}"
HOMEPAGE="http://www.gphoto.org"

DEPEND="virtual/glibc
	sys-apps/sed
	>=x11-libs/gtk+-1.2
	>=media-libs/imlib-1.8
	>=media-gfx/imagemagick-4.1"
	

src_compile() {                           
   try ./configure --prefix=/usr/ --mandir=/usr/share/man --infodir=/usr/share/info
   try make clean
   try make ${MAKEOPTS}
}

src_install() {                               
    try make prefix=${D}/usr/ mandir=${D}/usr/share/man infodir=${D}/usr/share/info install
    dodoc AUTHORS CONTACTS COPYING Changelog FAQ MANUAL NEWS* PROGRAMMERS \
	 README THANKS THEMES TODO
}





http://www.gphoto.net/dist/gphoto-0.4.3.tar.gz
