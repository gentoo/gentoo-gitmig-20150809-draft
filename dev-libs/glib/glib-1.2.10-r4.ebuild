# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/glib/glib-1.2.10-r4.ebuild,v 1.4 2002/08/01 16:50:26 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="The GLib library of C routines"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v1.2/${P}.tar.gz
	 ftp://ftp.gnome.org/pub/GNOME/stable/sources/glib/${P}.tar.gz"
HOMEPAGE="http://www.gtk.org/"

SLOT="1"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ppc" 

DEPEND="virtual/glibc"

src_compile() {

	econf \
		--with-threads=posix \
		--enable-debug=yes || die

	emake || die
}

src_install() {
	einstall || die
    
	( cd ${D}/usr/lib ; chmod 755 libgmodule-1.2.so.* )

	dodoc AUTHORS ChangeLog COPYING README* INSTALL NEWS

	dohtml -r docs
}
