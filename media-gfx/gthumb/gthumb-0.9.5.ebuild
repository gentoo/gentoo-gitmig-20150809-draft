# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gthumb/gthumb-0.9.5.ebuild,v 1.4 2002/07/11 06:30:27 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="gthumb is an Image Viewer and Browser for Gnome."
SRC_URI="http://gthumb.sourceforge.net/${P}.tar.gz"
HOMEPAGE="http://www.gthumb.sourceforge.net/index.html"

DEPEND=">=media-libs/gdk-pixbuf-0.11.0-r1
	>=gnome-base/gnome-vfs-1.0.2-r1
	>=gnome-base/gnome-print-0.30
	>=dev-libs/libxml-1.8.15
	>=gnome-base/bonobo-1.0.9-r1
	>=gnome-base/gnome-libs-1.4.1.2-r1
	>=gnome-base/libglade-0.17-r1"

src_compile() {
	./configure \
		--prefix=/usr || die

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README TODO

	doman ${S}/doc/gthumb.1 
}
