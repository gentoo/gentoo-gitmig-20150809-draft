# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/glademm/glademm-1.1.0c.ebuild,v 1.2 2002/07/23 11:22:18 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A C++ backend for glade-2, the GUI designer for Gtk."
SRC_URI="http://home.wtal.de/petig/Gtk/${P}.tar.gz"
HOMEPAGE="http://home.wtal.de/petig/Gtk/"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=dev-util/glade-1.1.0
	>=x11-libs/gtk+-2.0.0
	>=x11-libs/gtkmm-1.3.5
	>=dev-util/glade-1.1.0
	>=gnome-extra/libgnomemm-1.3.3"

src_compile() {
	econf || die
	make || die
}

src_install () {
	einstall || die
}
