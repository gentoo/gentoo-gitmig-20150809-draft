# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygtk/pygtk-0.6.9.ebuild,v 1.14 2003/09/11 01:14:04 msterret Exp $

DESCRIPTION="GTK+ bindings for Python"
HOMEPAGE="http://www.daa.com.au/~james/pygtk/"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/python/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="1.2"
KEYWORDS="x86 ppc sparc alpha"

DEPEND="virtual/python
	>=gnome-base/libglade-0.17-r6
	>=media-libs/imlib-1.8
	>=media-libs/gdk-pixbuf-0.9.0
	( >=x11-libs/gtk+-1.2.10
	<x11-libs/gtk+-2.0.0 )"

src_compile() {
	./configure --infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--prefix=/usr \
		--with-libglade-config=/usr/bin/libglade-config \
		--host=${CHOST} || die
	emake || die
}

src_install() {
	make prefix=${D}/usr install || die
}
