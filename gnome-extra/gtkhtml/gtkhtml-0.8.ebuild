# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gtkhtml/gtkhtml-0.8.ebuild,v 1.1 2000/12/21 08:22:28 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gtkhtml"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/gtkhtml/"${A}
HOMEPAGE="http://www.gnome.org/"
DEPEND=">=gnome-base/gal-0.2.2
	>=gnome-base/control-center-1.2.2
	>=gnome-base/glibwww-0.2
	>=app-text/pspell-0.11.2"
	

src_unpack() {
  	unpack ${A}
}

src_compile() {                           
  	cd ${S}
  	try LDFLAGS=\"-L/opt/gnome/lib -lunicode -lpspell\" ./configure --host=${CHOST} --prefix=/opt/gnome \
		--with-pspell --with-bonobo --with-gconf
 	 # bonobo support doesn't work yet	?
  	try make
}

src_install() {                               
  	cd ${S}
  	try make prefix=${D}/opt/gnome install
	insinto /opt/gnome/include/gtkhtml
	doins src/htmlurl.h
  	dodoc AUTHORS COPYING* ChangeLog README
  	dodoc NEWS TODO
}













