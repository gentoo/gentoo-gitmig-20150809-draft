# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="eel"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

DEPEND=">=gnome-base/gnome-vfs-1.0.1
        >=gnome-base/gdk-pixbuf-0.11.0
        >=media-libs/freetype-2.0.1
	>=gnome-libs/librsvg-1.0
        >=dev-util/xml-i18n-tools-0.8.4"

RDEPEND=">=media-libs/freetype-2.0.1
        >=gnome-base/gnome-vfs-1.0.1
        >=gnome-base/gdk-pixbuf-0.11.0
	>=gnome-libs/librsvg-1.0"

src_compile() {                           
  try ./configure --host=${CHOST} --prefix=/opt/gnome \
	--sysconfdir=/etc/opt/gnome
  try make  # Doesn't work with -j 4 (hallski)
}

src_install() {                               
  try make DESTDIR=${D} install
#  try make prefix=${D}/opt/gnome install

  dodoc AUTHORS COPYING ChangeLog NEWS README* TODO
}



