# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gtkam/gtkam-0.1.4.ebuild,v 1.2 2002/07/23 04:33:46 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A frontend for gPhoto 2"
HOMEPAGE="http://gphoto.org/gphoto2/gtk.html"
SRC_URI="mirror://sourceforge/gphoto/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=x11-libs/gtk+-1.2.10-r7
	>=media-libs/gdk-pixbuf-0.17.0
	>=media-gfx/gphoto2-2.0-r1"

RDEPEND="${DEPEND}"


src_compile() {
	econf --without-gimp || die
	emake || die
}

src_install () {

	einstall || die

	dodoc ABOUT-NLS AUTHORS COPYING INSTALL MANUAL NEWS README
}
