# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Martin Schlemmer <azarah@gentoo.org>

MY_P="glademm-0.5_11f"
S=${WORKDIR}/${MY_P}
DESCRIPTION="A C++ backend for glade, the GUI designer for Gtk."
SRC_URI="http://home.wtal.de/petig/Gtk/${MY_P}.tar.gz"
HOMEPAGE="http://home.wtal.de/petig/Gtk/"

DEPEND="gnome-apps/glade"

RDEPEND="x11-libs/gtk+
	 x11-libs/gtkmm
	 gnome-libs/gnomemm
	 gnome-apps/glade"


src_compile() {

	./configure --host=${CHOST} --prefix=/opt/gnome --mandir=/usr/share/man
	emake || die
	
}

src_install () {
	
	make  DESTDIR=${D} install || die

	dodoc AUTHORS BUGS COPYING ChangeLog INSTALL NEWS README TODO
	docinto docs
	dodoc docs/*.txt docs/*.html docs/glade.wishlist
	
}

