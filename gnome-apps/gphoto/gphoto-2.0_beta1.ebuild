# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author AJ Lewis <aj@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-apps/gphoto/gphoto-2.0_beta1.ebuild,v 1.1 2001/06/05 19:43:20 achim Exp $

A=${PN}-2.0beta1.tar.gz
S=${WORKDIR}/${PN}-2.0beta1
DESCRIPTION="free, redistributable digital camera software application"
SRC_URI="http://www.gphoto.net/dist/${A}"
HOMEPAGE="http://www.gphoto.org"

DEPEND="virtual/glibc >=dev-libs/libusb-0.1.3b >=dev-libs/glib-1.2.10 >=sys-libs/zlib-1.1.3"


src_compile() {

   # -pipe does no work
   cd libgphoto2_port
   try CFLAGS=\"${CFLAGS/-pipe/}\" ./configure --prefix=/usr --sysconfdir=/etc
   cd ..
   try CFLAGS=\"${CFLAGS/-pipe/}\" ./configure --prefix=/usr --sysconfdir=/etc
   # -j does not work
   try make
}

src_install() {
    try make prefix=${D}/usr sysconfdir=${D}/etc  install
    dodoc ChangeLog NEWS* README
    mv ${D}/usr/share/gphoto2/html ${D}/usr/share/doc/${PF}/sgml
    mv ${D}/usr/doc/gphoto2/* ${D}/usr/share/doc/${PF}
    rm -rf ${D}/usr/share/gphoto2 ${D}/usr/share/doc/${PF}/sgml/gphoto2 ${D}/usr/doc
    prepalldocs
}

