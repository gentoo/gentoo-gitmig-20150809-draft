# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Martin Schlemmer <azarah@gentoo.org>

MY_P="glademm-0.5_11f"
S=${WORKDIR}/${MY_P}
DESCRIPTION="A C++ backend for glade, the GUI designer for Gtk."
SRC_URI="http://home.wtal.de/petig/Gtk/${MY_P}.tar.gz"
HOMEPAGE="http://home.wtal.de/petig/Gtk/"

DEPEND=">=dev-util/glade-0.6.2"

RDEPEND=">=x11-libs/gtk+-1.2.10-r4
	 >=x11-libs/gtkmm-1.2.5-r1
	 >=dev-util/glade-0.6.2
	 >=gnome-extra/gnomemm-1.2.0-r1"


src_compile() {
	./configure --host=${CHOST} 					\
		    --prefix=/usr					\
		    --sysconfdir=/etc
	assert

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS BUGS COPYING ChangeLog INSTALL NEWS README TODO
	docinto docs
	dodoc docs/*.txt docs/*.html docs/glade.wishlist
}
