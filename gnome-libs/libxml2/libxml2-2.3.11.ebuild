# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-libs/libxml2/libxml2-2.3.11.ebuild,v 1.1 2001/06/18 15:22:39 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="libxml"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/libxml/${A}
         ftp://gnome.eazel.com/pub/gnome/stable/sources/libxml/${A}"
HOMEPAGE="http://www.gnome.org/"

DEPEND="virtual/glibc
        >=sys-libs/ncurses-5.2
        >=sys-libs/readline-4.1
	>=sys-libs/zlib-1.1.3" 

src_compile() {
  local myconf
  try ./configure --host=${CHOST} --prefix=/usr --sysconfdir=/etc --with-zlib 
  try make
}

src_install() {
  try make install prefix=${D}/usr sysconfdir=${D}/etc \
  mandir=${D}/usr/share/man
  dodoc AUTHORS COPYING* ChangeLog NEWS README
}







