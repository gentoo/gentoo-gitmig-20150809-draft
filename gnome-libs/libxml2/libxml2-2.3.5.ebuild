# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-libs/libxml2/libxml2-2.3.5.ebuild,v 1.2 2001/05/29 17:28:19 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="libxml"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/libxml/${A}
         ftp://gnome.eazel.com/pub/gnome/stable/sources/libxml/${A}"
HOMEPAGE="http://www.gnome.org/"

DEPEND="virtual/glibc
        >=sys-libs/ncurses-5.2
        >=sys-libs/readline-4.1
        gnome-base/gnome-env"

src_compile() {
  try ./configure --host=${CHOST} --prefix=/opt/gnome --sysconfdir=/etc/opt/gnome
  try make
}

src_install() {
  try make install prefix=${D}/opt/gnome sysconfdir=${D}/etc/opt/gnome mandir=${D}/opt/gnome/share/man
  dodoc AUTHORS COPYING* ChangeLog NEWS README
}







