# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Desktop Team <desktop@gentoo.org>
# Author Jens Blaesche <mr.big@pc-trouble.de>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gthumb/gthumb-0.9.5.ebuild,v 1.1 2001/10/01 10:45:44 hallski Exp $

S=${WORKDIR}/${P}
A=${P}.tar.gz
DESCRIPTION="gthumb is an Image Viewer and Browser for Gnome."
SRC_URI="http://gthumb.sourceforge.net/${A}"
HOMEPAGE="http://www.gthumb.sourceforge.net/index.html"

DEPEND=">=media-libs/gdk-pixbuf-0.9.0
	>=gnome-base/gnome-vfs-1.0
	>=gnome-base/gnome-print-0.25
	>=gnome-base/libxml-1.8.15
        >=gnome-base/bonobo-1.0.8
	>=gnome-base/gnome-libs-1.2.1
	>=gnome-base/libglade-0.14"

src_compile() {
	./configure --prefix=/opt/gnome --infodir=/usr/share/info 	\
		    --mandir=/usr/share/man --host=${CHOST} || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
	doman ${S}/doc/gthumb.1 
}

