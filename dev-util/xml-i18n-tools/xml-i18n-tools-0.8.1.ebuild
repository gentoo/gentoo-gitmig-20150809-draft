# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Gnome XML i18n tools"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}
         ftp://gnome.eazel.com/pub/gnome/stable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

DEPEND=">=sys-devel/perl-5.6.0"

src_compile() {                           

  try ./configure --host=${CHOST} --prefix=/usr
  try make
}

src_install() {

  try make DESTDIR=${D} install
  dodoc AUTHORS ChangeLog NEWS README
}





