# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gthumb/gthumb-0.13.ebuild,v 1.1 2002/07/16 19:56:15 stroke Exp $

S=${WORKDIR}/${P}
DESCRIPTION="gthumb is an Image Viewer and Browser for Gnome."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://gthumb.sourceforge.net/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=media-libs/gdk-pixbuf-0.11.0-r1
	=gnome-base/gnome-vfs-1.0*
	>=gnome-base/gnome-print-0.30
	>=dev-libs/libxml-1.8.15
	>=gnome-base/bonobo-1.0.9-r1
	>=gnome-base/gnome-libs-1.4.1.7
	( >=gnome-base/libglade-0.17-r1
	 <gnome-base/libglade-2.0.0 )"


RDEPEND="${DEPEND}"

src_compile() {
	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--sysconfdir=/etc \
		--localstatedir=/var/lib || die

	emake || die
}

src_install () {
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		sysconfdir=${D}/etc \
		localstatedir=${D}/var/lib \
	install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README TODO

	doman ${S}/doc/gthumb.1 
}
