# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="The Gnome WWW Libraries"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/${A}
         ftp://gnome.eazel.com/pub/gnome/unstable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

DEPEND=">=gnome-base/gnome-libs-1.2.13 >=net-libs/libwww-1.5.3-r1 gnome-base/gnome-env"
RDEPEND=">=net-libs/libwww-1.5.3-r1 gnome-base/gnome-env"

src_compile() {
  try ./configure --host=${CHOST} --prefix=/opt/gnome
  try make
}

src_install() {
  try make prefix=${D}/opt/gnome install
  dodoc AUTHORS ChangeLog NEWS README
}





