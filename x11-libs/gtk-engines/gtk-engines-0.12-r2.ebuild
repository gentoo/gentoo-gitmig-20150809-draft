# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtk-engines/gtk-engines-0.12-r2.ebuild,v 1.1 2001/10/06 10:08:19 azarah Exp $

A="${P}.tar.gz Xenophilia-1.2.x.tar.gz"
S=${WORKDIR}/${P}
DESCRIPTION="gtk-engines"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz http://download.themes.org/gtk/Xenophilia-1.2.x.tar.gz"
HOMEPAGE="http://www.gnome.org/"

DEPEND="virtual/glibc virtual/x11
	>=media-libs/imlib-1.9.10-r1"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	unpack Xenophilia-1.2.x.tar.gz
}

src_compile() {                           
  try ./configure --host=${CHOST} --prefix=/usr
  try make

	cd ${S}/Xenophilia-0.7
	try make PREFIX=/usr FONTDIR=/usr/X11R6/lib/X11/fonts/misc

}

src_install() {                               
  try make prefix=${D}/usr install
  dodoc AUTHORS COPYING* ChangeLog README NEWS
  cd Xenophilia-0.7
	try make PREFIX=${D}/usr FONTDIR=/usr/X11R6/lib/X11/fonts/misc install
  dodoc AUTHORS  CONFIGURATION TODO COPYING* ChangeLog README 
}




