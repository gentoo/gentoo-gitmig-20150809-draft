# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/glademm/glademm-1.1.0c.ebuild,v 1.1 2002/06/20 00:07:23 spider Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A C++ backend for glade-2, the GUI designer for Gtk."
SRC_URI="http://home.wtal.de/petig/Gtk/${P}.tar.gz"
HOMEPAGE="http://home.wtal.de/petig/Gtk/"

DEPEND=">=dev-util/glade-1.1.0"

RDEPEND=">=x11-libs/gtk+-2.0.0
	 >=x11-libs/gtkmm-1.3.5
	 >=dev-util/glade-1.1.0
	 >=gnome-extra/libgnomemm-1.3.3"


src_compile() {
	econf
	make || die
}

src_install () {
	einstall
#	dodoc AUTHORS BUGS COPYING ChangeLog INSTALL NEWS README TODO
#	dodoc docs/*.txt docs/glade.wishlist
#	docinto html
#	dodoc docs/*.html
}
