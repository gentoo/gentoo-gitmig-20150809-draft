# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/medusa/medusa-0.5.1.ebuild,v 1.1 2001/05/10 01:50:35 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="medusa"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}
         ftp://gnome.eazel.com/pub/gnome/stable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

DEPEND=">=gnome-base/gnome-vfs-1.0
        >=sys-libs/db-1.8"

src_compile() {                          
  try ./configure --host=${CHOST} --prefix=/opt/gnome \
        --sysconfdir=/etc/opt/gnome --mandir=/opt/gnome/share/man \
        --sharedstatedir=/var/lib --localstatedir=/var/lib --enable-prefere-db1
  try make medusainitdir=/tmp
}

src_install() {
  try make prefix=${D}/opt/gnome sysconfdir=${D}/etc/opt/gnome \
        medusainitdir=/tmp mandir=${D}/opt/gnome/share/man install
  dodoc AUTHORS COPYING ChangeLog NEWS README

}







