# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gtkam/gtkam-0.1.9.ebuild,v 1.8 2003/03/28 12:43:51 seemant Exp $

IUSE="nls"

S=${WORKDIR}/${P}
DESCRIPTION="A frontend for gPhoto 2"
HOMEPAGE="http://gphoto.org/gphoto2/gtk.html"
SRC_URI="mirror://sourceforge/gphoto/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"

DEPEND=">=x11-libs/gtk+-2
	>=media-gfx/gphoto2-2.1.0
	nls? ( sys-devel/gettext )"

src_compile() {
	# A Makefile hack to remove the spurious installation of
	# documentation into /usr/doc/gtkam
	cd ${S}
	cp Makefile.in Makefile.in.orig
	sed -e 's/install-data-am:.*/install-data-am:/g' Makefile.in.orig > Makefile.in
	rm Makefile.in.orig

	econf --without-gimp `use_enable nls` || die
	emake || die
}

src_install() {
	einstall || die

	dodoc ABOUT-NLS AUTHORS COPYING INSTALL MANUAL NEWS README
}
