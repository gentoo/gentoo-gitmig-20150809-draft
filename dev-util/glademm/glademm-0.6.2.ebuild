# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/glademm/glademm-0.6.2.ebuild,v 1.6 2002/07/23 11:22:18 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A C++ backend for glade, the GUI designer for Gtk."
SRC_URI="http://home.wtal.de/petig/Gtk/${P}.tar.gz"
HOMEPAGE="http://home.wtal.de/petig/Gtk/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=dev-util/glade-0.6.2
	=x11-libs/gtk+-1.2*
	>=x11-libs/gtkmm-1.2.5-r1
	>=dev-util/glade-0.6.2
	>=gnome-extra/gnomemm-1.2.0-r1"

src_compile() {
	econf || die
	emake || die
}

src_install () {

	einstall || die
	dodoc AUTHORS BUGS COPYING ChangeLog INSTALL NEWS README TODO
	dodoc docs/*.txt docs/glade.wishlist
	dohtml -r docs
}
