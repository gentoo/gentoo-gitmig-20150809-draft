# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Geert Bevin <gbevin@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/gtk-doc/gtk-doc-0.9-r2.ebuild,v 1.3 2002/05/21 18:14:08 danarmak Exp $

# ACONFVER=2.52f
# AMAKEVER=1.5b
# inherit autotools 

S=${WORKDIR}/${P}
DESCRIPTION="GTK+ Documentation Generator"
SRC_URI="ftp://ftp.gnome.org/pub/gnome/pre-gnome2/sources/gtk-doc/${P}.tar.gz"
HOMEPAGE="http://www.gtk.org/"

DEPEND="virtual/glibc
	>=dev-util/pkgconfig-0.12.0
	>=app-text/openjade-1.3
	>=app-text/docbook-sgml-dtd-4.1
	>=app-text/sgml-common-0.6.1
	>=app-text/docbook-sgml-1.0
	>=sys-devel/perl-5.0.0"
		
src_compile() {
	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--enable-debug=yes || die
	emake || die
}

src_install() {
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		install || die
	
	dodoc AUTHORS ChangeLog COPYING INSTALL README* NEWS 
	docinto doc
	dodoc doc/README doc/*.txt
	
}





