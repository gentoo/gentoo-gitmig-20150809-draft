# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gtkhtml/gtkhtml-0.7.ebuild,v 1.1 2000/10/31 02:43:30 drobbins Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gtkhtml"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/gtkhtml/"${A}
HOMEPAGE="http://www.gnome.org/"
DEPEND=">=gnome-base/gdk-pixbuf-0.8.0 >=gnome-base/bonobo-0.16 >=gnome-base/gnome-print-0.20 >=gnome-base/gconf-0.4"

src_unpack() {
  	unpack ${A}
}

src_compile() {                           
  	cd ${S}
  	try ./configure --host=${CHOST} --prefix=/opt/gnome --with-bonobo --with-gconf
 	 # bonobo support doesn't work yet	?
  	try make
}

src_install() {                               
  	cd ${S}
  	try make prefix=${D}/opt/gnome install
  	dodoc AUTHORS COPYING* ChangeLog README
  	dodoc NEWS TODO
}





