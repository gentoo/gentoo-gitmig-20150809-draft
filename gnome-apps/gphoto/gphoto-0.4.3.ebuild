# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author AJ Lewis <aj@gentoo.org>
# /home/cvsroot/gentoo-x86/gnome-apps/gphoto/gphoto-0.4.3.ebuild,v 1.7 2001/06/11 08:11:28 hallski Exp

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
   try CFLAGS="${CFLAGS/-pipe/}" ./configure --prefix=/opt/gnome --sysconfdir=/etc/opt/gnome
   try make clean
   try pmake
}

src_install() {
    try make prefix=${D}/opt/gnome sysconfdir=${D}/etc/opt/gnome  install
    dodoc AUTHORS CONTACTS COPYING ChangeLog FAQ MANUAL NEWS* PROGRAMMERS \
	 README THANKS THEMES TODO
}

