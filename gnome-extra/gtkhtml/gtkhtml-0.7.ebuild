# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gtkhtml/gtkhtml-0.7.ebuild,v 1.2 2000/11/25 12:57:02 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gtkhtml"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/gtkhtml/"${A}
HOMEPAGE="http://www.gnome.org/"
DEPEND=">=gnome-base/gal-0.2.2
	>=gnome-base/libglade-0.15
	>=gnome-base/libunicode-0.4
	>=gnome-base/control-center-1.2.2
	>=gnome-base/glibwww-0.2"

src_unpack() {
  	unpack ${A}
}

src_compile() {                           
  	cd ${S}
  	try LDFLAGS=\"-L/opt/gnome/lib -lunicode -lpspell\" ./configure --host=${CHOST} --prefix=/opt/gnome \
		--with-pspell --without-bonobo --without-gconf
 	 # bonobo support doesn't work yet	?
  	try make
}

src_install() {                               
  	cd ${S}
  	try make prefix=${D}/opt/gnome install
  	dodoc AUTHORS COPYING* ChangeLog README
  	dodoc NEWS TODO
}













