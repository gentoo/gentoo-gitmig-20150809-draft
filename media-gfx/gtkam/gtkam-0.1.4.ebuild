# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gtkam/gtkam-0.1.4.ebuild,v 1.1 2002/06/01 21:03:30 stroke Exp $

DESCRIPTION="A frontend for gPhoto 2"
HOMEPAGE="http://gphoto.org/gphoto2/gtk.html"
LICENSE="GPL-2"

SRC_URI="http://telia.dl.sourceforge.net/sourceforge/gphoto/${P}.tar.gz
	http://unc.dl.sourceforge.net/sourceforge/gphoto/${P}.tar.gz
	http://belnet.dl.sourceforge.net/sourceforge/gphoto/${P}.tar.gz"

SLOT="0"

DEPEND=">=x11-libs/gtk+-1.2.10-r7
	>=media-libs/gdk-pixbuf-0.17.0
	>=media-gfx/gphoto2-2.0-r1"
RDEPEND="${DEPEND}"


S=${WORKDIR}/${P}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--without-gimp || die

	emake || die
}

src_install () {

	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

	dodoc ABOUT-NLS AUTHORS COPYING INSTALL MANUAL NEWS README
}
