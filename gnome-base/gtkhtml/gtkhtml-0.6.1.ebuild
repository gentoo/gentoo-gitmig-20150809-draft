# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gtkhtml/gtkhtml-0.6.1.ebuild,v 1.4 2000/11/03 09:07:38 achim Exp $

P=gtkhtml-0.6.1
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gtkhtml"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/gtkhtml/"${A}
HOMEPAGE="http://www.gnome.org/"

DEPEND="=gnome-base/bonobo-0.18
	>=gnome-base/gconf-0.8
	>=gnome-base/control-center-1.2.1
	>=net-libs/libwww-5.3.1"

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/opt/gnome \
	--with-bonobo --with-gconf
  # bonobo support doesn't work yet
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/opt/gnome install
  dodoc AUTHORS COPYING* ChangeLog README
  dodoc NEWS TODO
}





